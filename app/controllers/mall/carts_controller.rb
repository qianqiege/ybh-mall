class Mall::CartsController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:show]
  include CurrentCart
  before_action :set_cart, only: [:show]

  def show
    @line_items = current_cart.line_items
    session[:line_item_ids] = nil
  end
end
