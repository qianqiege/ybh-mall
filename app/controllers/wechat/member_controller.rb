class Wechat::MemberController < Wechat::BaseController
  before_action :set_card, only: [:card]
  before_action :store_location, only: [:card,:equities]

  before_action :set_equity, only: [:equity]
  def card
    @slides = Slide.top(4)
    @no_fotter = true
  end

  def equity
    @no_fotter = true
  end

  def set_card
    @card = MembershipCard.where(member_club_id:params[:format])
  end

  def set_equity
    @equity = MemberEquity.where(membership_card_id:params[:format])
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
