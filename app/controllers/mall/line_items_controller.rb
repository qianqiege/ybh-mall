class Mall::LineItemsController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:create]
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    quantity = params[:quantity].to_i
    product = Product.find(params[:product_id])
    if quantity > product.shop_count.to_i
      render json: { exceed: "没有库存了" }
      return
    end
    @line_item = @cart.add_product(product, quantity)
    if @line_item.save
      render json: { quantity: quantity }
    else
      render json: @line_item.errors, status: :bad_request
    end
  end
end
