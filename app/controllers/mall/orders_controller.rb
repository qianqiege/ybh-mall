class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm, :create]
  include HasAddress
  before_action :check_has_address, only: [:confirm, :create]

  def create
    line_items = current_cart.line_items.where(id: session[:line_item_ids])
    # 1. 计算金额
    price = line_items.to_a.sum { |item| item.total_price }
    # 2. 计算商品数量
    quantity = line_items.to_a.sum { |item| item.quantity }
    # 3. 生成订单
    @order = current_user.orders.new(address_id: params[:address_id], price: price, quantity: quantity)

    if @order.save
      # 4. 清空购物车已生成订单的商品
      line_items.each do |line_item|
        line_item.move_to_order(@order)
      end
      # 5. 清空session
      session[:line_item_ids] = nil
      # 6. 跳转到支付页面
      redirect_to pay_mall_order_path(@order)
    else
      logger.info @order.errors.messages
      flash[:success] = "生成订单失败"
      redirect_to confirm_mall_orders_path(address_id: params[:address_id])
    end
  end

  def confirm
    @line_items = current_cart.line_items.where(id: session[:line_item_ids])
    @all_line_item_count =  @line_items.sum { |line_item| line_item.quantity }
    @total_price = @line_items.sum { |line_item| line_item.total_price }
    @recommend_address = current_user.addresses.find_by(id: params[:address_id]) || current_user.recommend_address
  end

  def pay
    @no_fotter = true
    @order = current_user.orders.find(params[:id])
  end
end
