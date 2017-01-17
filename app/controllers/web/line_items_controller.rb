class Web::LineItemsController < Web::BaseController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:destroy]

  def create
    quantity = params[:quantity].to_i
    product = Product.find(params[:product_id])

    @line_item = current_cart.add_product(product, quantity)
    @line_item.save
    redirect_to '/web/mall'
  end

  # 删除商品
  def destroy
    @line_item.destroy
    redirect_to '/web/cart'
  end

  private

  def set_line_item
    @line_item = current_cart.line_items.find(params[:id])
  end
end
