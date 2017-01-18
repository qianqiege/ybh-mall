class Web::CartsController < Web::BaseController
  include CurrentCart
  before_action :set_cart, only: [:show]

  def show
    @line_items = current_cart.reload.line_items
  end
end
