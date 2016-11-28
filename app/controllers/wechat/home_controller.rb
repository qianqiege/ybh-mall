class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @ybclub = MemberClub.where(vip_type_id:VipType.where(name:"御邦会员"))
    @ytclub = MemberClub.where(vip_type_id:VipType.where(name:"医通会员"))
  end
end
