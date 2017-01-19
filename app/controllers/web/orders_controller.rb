class Web::OrdersController < Web::BaseController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def index
    @orders = current_user.orders
  end

  def confirm
    unless session[:line_item_ids]
      session[:line_item_ids] = params[:line_item_ids].reject(&:blank?) if params[:line_item_ids]
    end
    @line_items = current_cart.line_items.where(id: session[:line_item_ids])
    @activities = Activity.all
    @addresses = current_user.addresses
  end

  def create
    # 没有像微信端那样加上确定库存的，这个可以以后再加
    line_items = current_cart.line_items.where(id: session[:line_item_ids])

    # 去掉库存为0的商品
    line_items = line_items.reject { |line_item| line_item.quantity == 0 }
    # 1. 计算金额(不包含下架的商品)
    price = line_items.to_a.sum { |item| item.total_price }
    # 2. 计算商品数量(不包含下架的商品)
    quantity = line_items.to_a.sum { |item| item.quantity }
    # 3. 生成订单
    @order = current_user.orders.new(
      price: price,
      quantity: quantity,
      address_id: params[:address_id],
      activity_id: params[:activity_id]
    )

    if @order.save
      # 4. 清空购物车已生成订单的商品
      line_items.each do |line_item|
        line_item.move_to_order(@order.id)
      end
      # 5. 清空session
      session[:line_item_ids] = nil

      flash['notice'] = '成功生成订单'
      redirect_to '/web/orders'
    else
      logger.info @order.errors.messages
      flash[:notice] = "生成订单失败"
      redirect_to '/web/mall'
    end
  end
end
