class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
