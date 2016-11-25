class Wechat::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @setmeal = Setmeal.all
    @ybclub = MemberClub.where(vip_type_id:1)
    @ytclub = MemberClub.where(vip_type_id:2)
  end
end
