class Wechat::HomeController < Wechat::BaseController
skip_before_filter :verify_authenticity_token
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @type = VipType.includes(:member_clubs)
  end

  def merchants
    @file_assets = FileAsset.all
  end

  def send_download_file
    send_file "#{Rails.root}/public/#{params[:file_url]}", :disposition => 'attachment'
  end

  def coalition
    @slides = Slide.top(8)
  end

  def donate_record
    @donation = DonationRecord.where(user_id: current_user.user_id)
  end

  def light_city
    @light = Light.last
  end

  def ticket_home
    @ticket = HightTicket.where(user_id: current_user.user_id,state: "start")
  end

  def light
    @wechat_user = WechatUser.find(current_user)
    if !current_user.user_id.nil?
      @user_type = User.find(current_user.user_id)
    else
      redirect_to '/user/binding'
    end
  end

  def use_ticket
    @ticket_number = HightTicket.find_by(id: params[:id])
  end

  def ticket
    ticket = HightTicket.find(params[:format])
    if !ticket.nil?
      url = wechat_not_ticket_url({ticket_number: ticket.ticket_number})
      @qrcode = RQRCode::QRCode.new(url, :size => 8, :level => :h)
    end
  end

  def not_ticket
    @ticket = HightTicket.where(ticket_number: params[:ticket_number],state: "start").take
    if !@ticket.nil?
      if @ticket.to_use
        redirect_to "/wechat/use_ticket/#{@ticket.id}"
      end
    else
      # flash[:notice] = '展票码已失效，请用户刷新页面'
      redirect_to "/wechat/use_ticket/0"
    end
  end

  def my_light
    @wechat_user = WechatUser.find(current_user)
    if !current_user.user_id.nil?
      @user_type = User.find(current_user.user_id)
    else
      redirect_to '/user/binding'
    end
  end

  def create_light

    # 人民币
    @price = params[:price].to_f
    # 积分
    @integral = params[:integral_available].to_f
    # 余额
    @cash = params[:integral_money].to_f

    if @integral > 0
      @integral = @integral/2
    end

    # @price 是应该付款的人民币数量
    @price = @price - @integral - @cash

    #支付方式
    payment = params[:payment]


    @donation_record = DonationRecord.create(user_id: current_user.user_id, price: @price, integral: @integral , cash: @cash, reason: "募集基金", payment: payment)


    redirect_to wechat_light_order_pay_path(@donation_record)

  end

  def light_order
    @price = params[:price]
    if Integral.find_by(user_id: current_user.user_id)
      @integral = Integral.find_by(user_id: current_user.user_id)
    end
  end

  #一盏明灯 确认支付
  def light_order_pay
    @no_fotter = true
    @donation_record = User.find(current_user.user_id).donation_records.find(params[:format])
    @trade_merge_pay_params = @donation_record.fast_pay.trade_merge_pay_params_donation_record(@donation_record.payment)
  end

  def coalition_edit_info
  end
end
