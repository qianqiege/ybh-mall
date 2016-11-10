class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide::Mall.where(is_show: true).order(weight: :asc).limit(3)
    @vip_types = VipType.all
    @setmeal = Setmeal.all
  end
end
