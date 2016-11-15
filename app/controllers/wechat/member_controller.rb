class Wechat::MemberController < Wechat::BaseController
  def index

  end
  def card
    @card = MembershipCard.all
    @slides = Slide.top(4)
  end
end
