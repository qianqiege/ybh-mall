class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @vip_yb = VipType.where(affiliation: "御邦会会员")
    @vip_yt = VipType.where(affiliation: "医通会会员")
    @setmeal = Setmeal.all
  end
end
