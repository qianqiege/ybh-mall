class Mall::LineItemsController < Mall::BaseController
  include CurrentCart
  before_action :set_cart, only: [:create]
  include BindPhone
  before_action :check_bind_phone, only: [:create]

  def create
    quantity = params[:quantity].to_i
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product, quantity)
    if @line_item.save
      render json: { quantity: quantity }
    else
      render json: @line_item.errors, status: :bad_request
    end
  end
end
