class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.where(is_show: true, tp: 2).order(weight: :asc).limit(3)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
