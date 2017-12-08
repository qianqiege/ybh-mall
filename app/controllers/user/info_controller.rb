class User::InfoController < Wechat::BaseController
  before_action :programs
  skip_before_filter :verify_authenticity_token

  def create_activity_code
    if params[:activity_desc].length >= 2
      apply_code = ApplyCode.new(user_id:current_user.user_id,desc: params[:activity_desc])
      if apply_code.save
        redirect_to "/user/apply_code?format=#{apply_code.id}"
      end
    else
      redirect_to "/user/apply_code"
    end
  end

  def auch_code
    @activity_code = ApplyCode.all
  end

  def update_code_ava
    if !params[:format].nil?
      code = ApplyCode.find(params[:format])
      if code.update_available!
        flash[:notice] = '操作成功，二维码已生效'
        redirect_to '/user/auch_code'
        return
      end
    end
  end

  def update_code_p_to_void
    if !params[:format].nil?
      code = ApplyCode.find(params[:format])
      if code.update_pending_to_void!
        flash[:notice] = '操作成功，二维码已生效'
        redirect_to '/user/auch_code'
        return
      end
    end
  end

  def update_code_void
    if !params[:format].nil?
      code = ApplyCode.find(params[:format])
      if code.update_available_to_void!
        flash[:notice] = '操作成功，二维码已失效'
        redirect_to '/user/auch_code'
        return
      end
    end
  end

  def apply_code
    @apply_code = ApplyCode.where("user_id = ? && state != ?",current_user.user_id,"void")
  end

  def activity_code
    if !params[:format].nil?
      apply_code = ApplyCode.find(params[:format])
      url = user_gave_money_url(number: 100,code_id: apply_code.id)
      @activity_code = RQRCode::QRCode.new(url, :size => 8, :level => :h)
    else
      url = user_gave_money_url(number: 100)
      @activity_code = RQRCode::QRCode.new(url, :size => 8, :level => :h)
    end
  end

  def gave_money
    if !current_user.user.nil?
      record = PresentedRecord.new(user_id: current_user.user_id,number: params[:number],is_effective: 1,reason: "活动推广赠送",type: "Notexchange")
      code = ApplyCode.find_bye(id: params[:code_id])
      if !code.nil? && code.state != "void"
        @user = PresentedRecord.where("user_id = ? && code_id = ?",current_user.user_id,code.id)
        record.code_id = code.id
        record.desc = code.desc
        if current_user.user.status != "Staff" && @user[0].nil? && record.save
          redirect_to '/user/prompt'
          return
        else
          flash[:notice] = '您已经参加过该活动'
          redirect_to '/wechat'
          return
        end
      else
        flash[:notice] = '对不起，您扫的二维码不存在或已失效'
        redirect_to '/wechat'
        return
      end
    else
      redirect_to '/user/binding'
      return
    end
  end

  def doctor_home
      @slides = Slide.top(1)
      @user_info_review = UserInfoReview.where(identity: 'family_doctor',
      identity: 'family_health_manager',identity: 'helath_manager').order(ranking: :desc).limit(10)
  end

  def doctor_user
      if current_user.user.id_number
         if params[:format].present?
            DoctorOrUser.create(user_id: current_user.user_id,doctor_id: params[:format])
         end
         @doctor_user = DoctorOrUser.where(user_id: current_user.user_id)
         @doctor_info = UserInfoReview.where(user_id: @doctor_user.pluck(:doctor_id))
      else
         redirect_to user_edit_info_path, notice: "请完善身份证信息，再申请!"
      end
  end

  def health_data
    @user_email = User.find(current_user.user_id)
    @health_identity_card = params[:identity_card] || ""
    mall = Sdk::Mall.new
    @phone = mall.get_phone_email(@user_email.email)
  end

  def invitation_info
    @invitation_order = Order.where(user_id: params[:format])
  end

  def health_data_post
    mall = Sdk::Mall.new
    email = params["email"]
    id = params["identity_card"]
    phone = params["phone"]
    @temporary_data = TemporaryDatum.new(identity_card: id,phone: phone)
    if mall.health_data(email,id) && @temporary_data.save
      flash[:notice] = '上传成功'
      redirect_to '/user/health_data'
    else
      flash[:notice] = '上传失败，邮箱或身份证有误'
      redirect_to '/user/health_data'
    end
  end

  def edit_info
    @info = User.find(current_user.user_id)
    if params[:format] == "1"
      flash[:notice] = '请您填写您的身份证号码，才可以使用此功能'
    end
  end

  def user_edit_info
    @user = User.find_by(id: params[:u_id])
    @old = @user.identity_card
    if @user.update(telphone: params[:telphone],email: params[:email],id_number: params[:id_number],identity_card: params[:id_number])
      flash[:notice] = '修改成功'
      mall = Sdk::Mall.new
      mall.update_id_number(@old,params[:id_number])
      redirect_to '/user/setting'
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
    @available = Integral.find_by(user_id: current_user.user_id)
    @user_available_y = @available.available
  end

  def create_gift_friend
    if !current_user.nil? && !current_user.user_id.nil? && current_user.user.id_number.nil?
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
    else
      flash[:notice] = '兑换积分需要实名注册'
      redirect_to user_edit_info_path
      return
    end
  end

  def create_gift

    if !current_user.nil? && !current_user.user_id.nil? && current_user.user.id_number.nil?
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
    else
      flash[:notice] = '兑换积分需要实名注册'
      redirect_to user_edit_info_path
      return
    end

  end

  def gift_user

    if !current_user.nil? && !current_user.user_id.nil? && !current_user.user.id_number.nil?

      if params[:account_type] == "支付宝" && params["type_coin"] != "1"
        if params[:tel] == "" || params[:account] == ""
          flash[:notice] = '申请信息不能为空值'
          redirect_to user_gift_account_path
          return
        end
      elsif params[:account_type] == "银行卡" && params["type_coin"] != "1"
        if params[:bank_name] == "" || params[:bank] == "" || params[:where] == ""
          flash[:notice] = '申请信息不能为空值'
          redirect_to user_gift_account_path
          return
        end
      end

      integral = Integral.find_by(user_id: current_user.user_id)
      type = User.find(current_user.user_id).status
      order_integral = params["quantity"].to_f
      number = params["quantity"].to_f
      # 查找当前用户记录
      if Integral.find_by(user_id: params["id"].to_i).nil?
        Integral.create(user_id: params["id"].to_i)
      end

      if number >= 10 && number%10 == 0
        # 判断当前用户的可兑换积分数量是否大于赠送积分
        if integral.exchange >= order_integral
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
        flash[:notice] = '失败，数量不能小于10并且是10的倍数'
        redirect_to user_details_path
        return
      end

      if params["type_coin"] == "1" && order_integral == 0
        invitation_record = PresentedRecord.new(user_id: params["id"], number: number, reason: "好友赠送", is_effective:1, type: "Available",wight: 11,is_effective: 1)
        if invitation_record.save
          integral.update(available: integral.available - number)
          flash[:notice] = '赠送成功'
          redirect_to user_details_path
          return
        end
      end

      @exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: "错误",account: "错误",name: "错误",state: "not")

      if params["type_coin"] == "0" && order_integral == 0
        if number >= 10 && number%10 == 0
          if params["account_type"] == "支付宝"
            @exchange_record = ExchangeRecord.new(user_id: integral.user_id,tel: params[:tel],number: params["quantity"].to_f,status: params["account_type"],account: params["account"],name: current_user.user.name,state: "pending")
          elsif params["account_type"] == "银行卡"
            @exchange_record = ExchangeRecord.new(user_id: integral.user_id,number: params["quantity"].to_f,status: params["account_type"],account: params["bank"],opening: params["where"],name: current_user.user.name,state: "pending")
          end

          if @exchange_record.save
            PresentedRecord.create(user_id: params["id"].to_i, number: params["quantity"].to_f, reason: "接受提现申请",is_effective:1,type:"Available",wight: 0)
            integral.update(available: integral.available - number,exchange: integral.exchange - number,not_appreciation: integral.not_appreciation - number)
            flash[:notice] = '兑换成功'

            #用户提现申请成功，发送模板通知消息
            @exchange_record.send_exchange_record_apply_success

            redirect_to user_gift_account_path
            return
          else
            flash[:notice] = '兑换失败'
            redirect_to user_gift_account_path
            return
          end
        else
          flash[:notice] = '兑换失败，兑换数量不能小于10并且是10的倍数'
          redirect_to user_gift_account_path
          return
        end
      end
    else
      flash[:notice] = '兑换积分需要实名注册'
      redirect_to user_edit_info_path
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
    if !current_user.user_id.nil?
      @user_type = User.find(current_user.user_id)
    else
      redirect_to '/user/binding'
    end
  end

  # 医师认证
  def authentication
    @user_info_review = current_user.user.user_info_review
    if !@user_info_review
      @user_info_review = UserInfoReview.create!(user_id: current_user.user.id, identity: 'user')
    end
  end

  # 医馆认证
  def shop_authentication
    @shop = current_user.user.shop
    if !@shop
      @shop = Shop.create!(user_id: current_user.user.id)
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
    @user_info_review = current_user.user.user_info_review
  end

  def edit_user_info_review
    @user_info_review = UserInfoReview.find_by(id: params[:id])
    if @user_info_review.blank?
       @user_info_review = UserInfoReview.new
    end
  end

  def update_user_info_review
    @user_info_review = UserInfoReview.find_by(id: params[:id])
    if params[:sameaddress] == "on"
        format_data = {
          identity: params[:identity],
          work_province: params[:work_address][:province],
          work_city: params[:work_address][:city],
          work_street: params[:work_address][:street],
          resident_province: params[:work_address][:province],
          resident_city: params[:work_address][:city],
          resident_street: params[:work_address][:street],
          doctor_number: params[:doctor_number]
        }
        if @user_info_review.blank?
          review = UserInfoReview.new(format_data)
          review.user_id = current_user.user.id
          review.save!
        else
          format_data[:state] = "pending"
          @user_info_review.update(format_data)
        end
    else
        format_data = {
          identity: params[:identity],
          work_province: params[:work_address][:province],
          work_city: params[:work_address][:city],
          work_street: params[:work_address][:street],
          resident_province: params[:resident_address][:province],
          resident_city: params[:resident_address][:city],
          resident_street: params[:resident_address][:street],
          doctor_number: params[:doctor_number]
        }
        if @user_info_review.blank?
          review = UserInfoReview.new(format_data)
          review.user_id = current_user.user.id
          review.save!
        else
          format_data[:state] = "pending"
          @user_info_review.update(format_data)
        end
    end

    redirect_to user_setting_path
  end

  def upload_image
    url = $wechat_client.download_media_url(params["serverId"])
    current_user.user.identity_cards.create(remote_image_url: url)

    render_success
  end

  def upload_user_image
    url = $wechat_client.download_media_url(params["serverId"])
    if current_user.user.user_info_review
      current_user.user.user_info_review.update(remote_image_url: url)
    else
      UserInfoReview.create!(remote_image_url: url, user_id: current_user.user.id, identity: 'user')
    end

    render_success
  end

  def upload_doctor_image
    url = $wechat_client.download_media_url(params["serverId"])
    if current_user.user.user_info_review
      current_user.user.user_info_review.update(remote_doctor_image_url: url)
    else
      UserInfoReview.create!(remote_doctor_image_url: url, user_id: current_user.user.id, identity: 'user')
    end

    render_success
  end

  def upload_education_image
    url = $wechat_client.download_media_url(params["serverId"])
    if current_user.user.user_info_review
      current_user.user.user_info_review.update(remote_education_image_url: url)
    else
      UserInfoReview.create!(remote_education_image_url: url, user_id: current_user.user.id, identity: 'user')
    end

    render_success
  end

  def upload_other_image
    url = $wechat_client.download_media_url(params["serverId"])
    if current_user.user.user_info_review
      current_user.user.user_info_review.update(remote_other_image_url: url)
    else
      UserInfoReview.create!(remote_other_image_url: url, user_id: current_user.user.id, identity: 'user')
    end

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
    if params[:id]
      @idcard = User.find(params[:id])
    elsif !current_user.user_id.nil?
      @idcard = User.find(current_user.user_id)
    end
    mall = Sdk::Mall.new
    @record = mall.record(@idcard.identity_card)
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
      @program_id = params[:format]
    end
  end

  def health_programs
    if !@program_id.nil?
      @search_programs = @programs.find(@program_id).product
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

  #数动力样例展示
  def idata_example_show

  end

  #数动力详细说明
  def idata_detail_explanation

  end

  def create_programs
    if params["commit"] == "立刻购买"
      @program_id = params[:format]
      if !@program_id.nil?
        @search_programs = @programs.find(@program_id)
        @only_number = JSON.parse(@search_programs.product)
        item_id = Array.new
        i = 0
        if !@only_number.nil?
          @only_number.each do |only_number|
            product = Product.find_by(only_number: only_number["产品编号"])
            if !product.nil?
              quantity = only_number["数量"].to_i
              @line_item = current_user.cart.add_product(product, quantity)
              @line_item.save
              item_id[i] = @line_item.id
              i = i + 1
            end
          end
          session[:programs_number] = @search_programs.coding
          session[:line_item_ids] = item_id
          redirect_to confirm_mall_orders_path
          return
        end
      end
    end
  end

end
