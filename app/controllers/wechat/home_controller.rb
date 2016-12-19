class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @type = VipType.includes(:member_clubs)
    @user = discount
  end
end
