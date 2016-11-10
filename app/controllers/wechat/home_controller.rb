class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide::Home.where(is_show: true).order(weight: :asc).limit(3)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
