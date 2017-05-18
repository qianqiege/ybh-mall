class User::InfoController < Wechat::BaseController
  before_action :programs

  def invitation
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
  end

  def create_exchange
  end

  def gift_account
    available = Integral.find_by(user_id: current_user.user_id)
    @user_available_y = available.exchange
  end

  def create_gift
    search_user = params["mobile"]
    case search_user.length
    when 11
      @gift_user = User.find_by(telphone: search_user)
    when 18
      @gift_user = User.find_by(identity_card: search_user)
    else
    end
  end

  def gift_user
    integral = Integral.find_by(user_id: current_user.user_id)
    number = params["quantity"].to_f
    # 查找当前用户记录
    if Integral.find_by(user_id: params["id"].to_i).nil?
      Integral.create(user_id: params["id"].to_i)
    end
    if number > 0
      # 判断当前用户的可兑换积分数量是否大于赠送积分
      if integral.exchange > number
        order_integral = number
        record = PresentedRecord.where(user_id: params["id"].to_i).order(wight: :desc)
        record.each do |record|
          if !record.balance.nil? && record.balance > 0
            while order_integral > 0
              if record.balance >= order_integral
                PresentedRecord.create(user_id: integral.user_id, number: "-#{order_integral}", reason: "赠送/兑换", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.update(balance: record.balance - order_integral)
                order_integral = 0
                break
              elsif record.balance <= order_integral
                order_integral = order_integral - record.balance
                PresentedRecord.create(user_id: integral.user_id, number: "-#{record.balance}", reason: "兑换", is_effective:0, type: record.type ,record_id: record.id,wight: record.wight)
                record.balance = 0
                if record.save
                  break
                end
              end
            end
          end
        end

        PresentedRecord.create(user_id: params["id"].to_i, number: params["quantity"].to_f, reason: "接受提现申请",is_effective:0,type:"Available")

        if params["account_type"] == "支付宝"
          exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: params["account_type"],account: params["account"],name: params["name"])
        elsif params["account_type"] == "银行卡"
          exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: params["account_type"],account: params["bank"],opening: params["where"],name: params["bank_name"])
        end

        # integral_record = PresentedRecord.new(user_id: integral.user_id, number: "-#{params["price"].to_f}", reason: "转账",is_effective:0,type:"Available")
        if exchange_record.save
          flash[:notice] = '赠送成功'
          redirect_to user_gift_account_path
          return
        else
          flash[:notice] = '赠送失败'
          redirect_to user_gift_account_path
          return
        end
      end
    else
      flash[:notice] = '赠送失败，赠送数量不合法'
      redirect_to user_gift_account_path
      return
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
    @ycoin = User.find(current_user.user_id)
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

  def account_details

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
