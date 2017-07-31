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

  def light

  end

  def light_raise

  end

  def light_intro

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
