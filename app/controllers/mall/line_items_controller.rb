class Mall::LineItemsController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:create]
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:add, :remove, :destroy]

  def create
    quantity = params[:quantity].to_i
    product = Product.find(params[:product_id])

    # 库存为0的情况
    if product.shop_count == 0
      render json: { exceed: "没有库存了" }
      return
    end

    # 控制库存数量
    current_item = @cart.line_items.find_by(product_id: product.id)
    if current_item && (quantity + current_item.quantity > product.shop_count.to_i)
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

  def add
    # 为了安全，需要检测库存数量
    if @line_item.quantity >= @line_item.product.shop_count
      render json: { exceed: "没有库存了" }
      return
    end

    @line_item.increment! :quantity
    @action = 'add'
    render 'carts_line_item.json.jbuilder'
  end

  def remove
    # 为了安全，需要检测库存数量
    if @line_item.quantity == 1
      render json: { exceed: "已经到最小购买数量了" }
      return
    end

    @line_item.decrement! :quantity
    @action = 'remove'
    render 'carts_line_item.json.jbuilder'
  end

  def destroy
    @line_item.destroy
    @action = 'delete'
    render 'carts_line_item.json.jbuilder'
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
