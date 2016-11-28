class Wechat::MemberController < Wechat::BaseController
  before_action :set_card, only: [:card]
  before_action :store_location, only: [:card,:equity]

  before_action :set_equity, only: [:equity]
  def card
    @no_fotter = true
    @slides = Slide.top(4)
  end

  def equity
    @no_fotter = true
    @discount = MemberEquity.where(membership_card_id:params[:format]).take
  end

  def set_card
    @card = MembershipCard.where(member_club_id:params[:format])
    @clubname = MembershipCard.where(member_club_id:params[:format]).take
  end

  def set_equity
    @equity = MemberEquity.where(membership_card_id:params[:format])
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
