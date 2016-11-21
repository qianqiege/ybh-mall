class Mall::CartsController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:show]
  include CurrentCart
  before_action :set_cart, :check_cart_product_count, only: [:show]

  def show
    @line_items = current_cart.reload.line_items
    session[:line_item_ids] = nil
  end
end
