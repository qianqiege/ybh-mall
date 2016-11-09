class Wechat::MemberController < Wechat::BaseController
  def index
    @vip_lvs = VipLv.all
    @slides = Slide.where(is_show: true).order(weight: :asc).limit(3)
  end

end
