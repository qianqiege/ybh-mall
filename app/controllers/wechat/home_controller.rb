class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
