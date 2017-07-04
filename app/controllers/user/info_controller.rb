class User::InfoController < Wechat::BaseController
  before_action :programs

  def health_data
    @user_email = User.find(current_user.user_id)
    @health_identity_card = params[:identity_card] || ""
  end

  def health_data_post
    mall = Sdk::Mall.new
    email = params["email"]
    id = params["identity_card"]
    if mall.health_data(email,id)
      flash[:notice] = '上传成功'
      redirect_to '/user/health_data'
    else
      flash[:notice] = '上传失败，邮箱或身份证有误'
      redirect_to '/user/health_data'
    end
  end

  def invitation
    @wechat_user = WechatUser.find(current_user)
    if current_user.user
      url = user_binding_url({invitation_id: current_user.user.invitation_card})
      @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
      @invitation_card = User.find(current_user.user_id).invitation_card
    else
      redirect_to '/user/binding'
    end
  end

  def exchange
    available = Integral.find_by(user_id: current_user.user_id)
    @available_ycoin = available.exchange
    @cash_record = CashRecord.new
  end

  #现金提现
  def create_exchange
     format_data = {
      account: params[:account],
      reason: "提现",
      status: params[:account_type],
      number: -params[:quantity].to_f,
      user_id: current_user.user_id
    }
    @cash_record = CashRecord.new(format_data)

    if params[:account_type] == "支付宝" && params[:account].to_s.length != 11
      render  action: :exchange
    elsif  params[:quantity].to_f <= 0
      render action: :exchange
    else
      @cash_record.save
      flash[:notice] = "申请提现成功"
      redirect_to user_transaction_path
    end

  end

  #现金充值
  def create_deposit_exchange
    format_data = {
      price: params[:price].to_f,
      payment: params[:payment]
    }
    @deposit = User.find(current_user.user_id).deposits.new(format_data)
    if @deposit.save
      redirect_to user_deposit_pay_path(@deposit)
    end
  end

  #支付确认
  def deposit_pay
    @no_fotter = true
    @deposit = User.find(current_user.user_id).deposits.find(params[:format])
    @trade_merge_pay_params = @deposit.fast_pay.trade_merge_pay_params_deposit(@deposit.payment)
  end

  def gift_account
    available = Integral.find_by(user_id: current_user.user_id)
    @user_available_y = available.exchange
  end

  def create_gift_friend
    search_user = params["mobile"]
    case search_user.length
    when 11
      @gift_friend = User.find_by(telphone: search_user)
      @w_friend = WechatUser.find_by(user_id: @gift_friend.id)
    when 18
      @gift_friend = User.find_by(identity_card: search_user)
      @w_friend = WechatUser.find_by(user_id: @gift_friend.id)
    else
    end
  end

  def create_gift
    search_user = params["mobile"]
    case search_user.length
    when 11
      @gift_user = User.find_by(telphone: search_user)
      @w_user = WechatUser.find_by(user_id: @gift_user.id)
    when 18
      @gift_user = User.find_by(identity_card: search_user)
      @w_user = WechatUser.find_by(user_id: @gift_user.id)
    else
    end
  end

  def gift_user
    integral = Integral.find_by(user_id: current_user.user_id)
    type = User.find(current_user.user_id).status
    order_integral = params["quantity"].to_f
    number = params["quantity"].to_f
    # 查找当前用户记录
    if Integral.find_by(user_id: params["id"].to_i).nil?
      Integral.create(user_id: params["id"].to_i)
    end

    if type == "staff" || type == "Staff" || number >= 400 && number%20 == 0
      # 判断当前用户的可兑换积分数量是否大于赠送积分
      if integral.exchange > order_integral
        record = PresentedRecord.where(user_id: integral.user_id).order(wight: :desc)
        record.each do |record|
          if !record.balance.nil? && record.balance > 0
            while order_integral > 0
              if record.balance >= order_integral
                PresentedRecord.create(user_id: integral.user_id, number: "-#{order_integral}", reason: "兑换/赠送", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.update(balance: record.balance - order_integral)
                order_integral = 0
                break
              elsif record.balance <= order_integral
                order_integral = order_integral - record.balance
                PresentedRecord.create(user_id: integral.user_id, number: "-#{record.balance}", reason: "兑换/赠送", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.balance = 0
                if record.save
                  break
                end
              end
            end
          end
        end
        # flash[:notice] = '赠送成功'
        # redirect_to user_gift_path
        # return
      end
    else
      flash[:notice] = '失败，数量不能小于400并且是20的倍数'
      redirect_to user_details_path
      return
    end

    if params["type_coin"] == "1" && order_integral == 0
      invitation_record = PresentedRecord.new(user_id: params["id"], number: number, reason: "好友赠送", is_effective:1, type: "Available",wight: 11,is_effective: 1)
      if invitation_record.save
        integral.update(available: integral.available - number,exchange: integral.exchange - number,not_appreciation: integral.not_appreciation - number)
        flash[:notice] = '赠送成功'
        redirect_to user_details_path
        return
      end
    end

    if params["type_coin"] == "0" && order_integral == 0
      if number >= 400 && number%20 == 0
        if params["account_type"] == "支付宝"
          @exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: params["account_type"],account: params["account"],name: current_user.user.name,state: "pending")
        elsif params["account_type"] == "银行卡"
          @exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: params["account_type"],account: params["bank"],opening: params["where"],name: current_user.user.name,state: "pending")
        end

        if @exchange_record.save
          PresentedRecord.create(user_id: params["id"].to_i, number: params["quantity"].to_f, reason: "接受提现申请",is_effective:1,type:"Available",wight: 0)
          integral.update(available: integral.available - number,exchange: integral.exchange - number,not_appreciation: integral.not_appreciation - number)
          flash[:notice] = '兑换成功'
          redirect_to user_gift_account_path
          return
        else
          flash[:notice] = '兑换失败'
          redirect_to user_gift_account_path
          return
        end
      else
        flash[:notice] = '兑换失败，兑换数量不能小于400并且是20的倍数'
        redirect_to user_gift_account_path
        return
      end
    end
  end

  def invitation_friend
    if !current_user.user_id.nil?
      @my_name = User.find(current_user.user_id)
      @invitation_friend = User.where(invitation_id: @my_name.id)
    end
  end

  def home
    @wechat_user = WechatUser.find(current_user)
    if !current_user.user_id.nil?
      @user_type = User.find(current_user.user_id)
    else
      redirect_to '/user/binding'
    end
  end

  def gift_friend
    available = Integral.find_by(user_id: current_user.user_id)
    @user_available_y = available.exchange
  end

  def transaction
    if !current_user.user_id.nil?
      @show = CashRecord.where(user_id: current_user.user_id)
      @options = {
        colors: ["#ff0000", "#add9c0"],
        xAxis: {
          type: 'datetime',
          labels: {
            format: '{value:%m-%d}',
            align: 'right'
          }
        }
      }
    end
  end

  def setting
    if !(current_user.mobile.present? && current_user.user.present?)
      redirect_to '/user/binding'
      return
    end
    @wechat_user = WechatUser.find(current_user)
    @identity_cards = current_user.user.identity_cards
    @show_upload_btn = @identity_cards.count < 4
  end

  def upload_image
    url = $wechat_client.download_media_url(params["serverId"])
    current_user.user.identity_cards.create(remote_image_url: url)

    render_success
  end

  def wallet_scoin
    if !current_user.user_id.nil?
      @scoin_account = ScoinAccount.where(user_id:current_user.user_id)
      @sum = 0
      @count = 0
      @scoin_account.each do |scoin|
        if !scoin.number.nil?
          @sum = @sum + scoin.number
        end
        if !scoin.id.nil?
          @scoin_type = ScoinType.where(id: ScoinRecord.where(account_id: scoin.id).pluck(:coin_type_id))
          @scoin_type.each do |type|
            @count = @count + type.count
          end
        end
      end
    end
  end

  def wallet
    @exchange_r = ExchangeRecord.where(user_id: current_user.user_id)
    @cash = CashRecord.where(user_id: current_user.user_id).where(reason: "提现")
  end

  def do_query_wallet
    if !params[:username].present? || !params[:password].present?
      render json: { status: 'error', message: '请填写用户名和密码' }
    else
      if QueryCoin.query(params[:username], params[:password])
        render json: { status: 'ok' }
      else
        render json: { status: 'error', message: '登录失败，账号或密码不正确'}
      end
    end
  end

  def query_wallet
    @ycoin = User.find(current_user.user_id)
    @coin = QueryCoin.query(params[:username], params[:password])
    logger.info @coin
  end

  def health_record
    if !current_user.user_id.nil?
      @idcard = User.find(current_user.user_id)
      mall = Sdk::Mall.new
      @record = mall.record(@idcard.identity_card)
    end
  end

  def wechat_info
    @wechat_info = WechatUser.find(current_user)
  end

  def scoin_info
    @id = params[:format]
    @scoin_record = ScoinRecord.where(scoin_account_id: @id)
    @scoin_account = ScoinAccount.find_by(id: @id)
  end

  def member_info
    @member = MemberRecord.where(user_id: current_user.user_id).take
  end

  def tds_record
    if !current_user.user_id.nil?
      @idcard = User.find(current_user.user_id)
      mall = Sdk::Mall.new
      @tds_record = mall.tds_report(@idcard.identity_card)
    end
  end

  def programs
    if !current_user.user_id.nil?
      @programs = HealthProgram.where(identity_card: User.find(current_user.user_id).identity_card)
      @time_programs = @programs.order(time: :desc).limit(10)
      @time = params[:format]
    end
  end

  def health_programs
    if !@time.nil?
      @search_programs = @programs.where(time: @time).take.product
      @only_number = JSON.parse(@search_programs)
      cart = current_user.cart || current_user.create_cart
      @only_number.each do |only_number|
       if product = Product.find_by(only_number: "1010")
         if !cart.nil?
           @line_item = cart.add_product(product,1)
         end
       end
     end
   end
  end

  def record_home
    if current_user.user
      url = user_health_data_url({identity_card: current_user.user.identity_card})
      @health_rqrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
      @health_identity_card = User.find(current_user.user_id).identity_card
    else
      redirect_to '/user/binding'
    end
  end

  def moving_health_data

  end

  def create_programs
    if params["commit"] == "加入到购物车"
      @time = params[:format]
      if !@time.nil?
        @search_programs = @programs.where(time: @time).take.product
        @only_number = JSON.parse(@search_programs)
        if !@only_number.nil?
          @only_number.each do |only_number|
            product = Product.find_by(only_number: only_number["产品编号"])
            if !product.nil?
              quantity = only_number["数量"].to_i
              @line_item = current_user.cart.add_product(product, quantity)
              @line_item.save
            end
          end
          redirect_to mall_cart_path
          return
        end
      end
    end
  end

end
