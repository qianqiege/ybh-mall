class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.where(is_show: true, tp: 1).order(weight: :asc).limit(3)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
