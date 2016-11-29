class Mall::LineItemsController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:create]
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:add, :remove, :destroy]
  after_action :set_real_quantity, only: [:add, :remove]

  # 加入购物车和立即购买
  def create
    quantity = params[:quantity].to_i
    product = Product.find(params[:product_id])

    @line_item = current_cart.add_product(product, quantity)
    @line_item.save
    render 'carts_line_item.json.jbuilder'
  end

  # 购物车增加商品数量
  def add
    @line_item.quantity += 1
    @line_item.save
    @action = 'add'
    render 'carts_line_item.json.jbuilder'
  end

  # 购物车减少商品数量
  def remove
    @line_item.quantity -= 1
    @line_item.save
    @action = 'remove'
    render 'carts_line_item.json.jbuilder'
  end

  # 删除商品
  def destroy
    @line_item.destroy
    @action = 'delete'
    render 'carts_line_item.json.jbuilder'
  end

  private

  def set_line_item
    @line_item = current_cart.line_items.find(params[:id])
  end

  def set_real_quantity
    @line_item.update_attribute(:quantity, @line_item.reload.real_quantity)
  end
end
