class Wechat::MemberController < Wechat::BaseController
  before_action :set_product, only: [:club]
  before_action :store_location, only: [:club]
  def club
    @slides = Slide.top(4)
    @no_fotter = true
  end

  def set_product
    @club = MemberClub.where(vip_type_id:params[:format])
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
