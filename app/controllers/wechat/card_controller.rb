class Wechat::CardController < Wechat::BaseController
  before_action :card, only: [:show]

  def show
  end

  private
  def card
    @vipcard = VipCard.find(params[:id])
  end

end
