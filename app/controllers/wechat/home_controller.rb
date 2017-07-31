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

  end

  def light_order
    @price = params[:price]
    if Integral.find_by(user_id: current_user.user_id)
      @integral = Integral.find_by(user_id: current_user.user_id)
    end
  end

  def coalition_edit_info
  end
end
