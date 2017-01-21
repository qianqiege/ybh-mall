class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm, :create]
  include HasAddress
  before_action :check_has_address, only: [:confirm, :create]
  include CurrentCart
  before_action :check_cart, only: [:confirm]

  def index
    @title = params[:status] ? Order::STATUS_TEXT[params[:status].to_sym].to_s + '订单' : '全部订单'
    @orders = if params[:status]
      current_user.orders.where(status: params[:status])
    else
      current_user.orders
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    # 需要处理两种特殊情况，第一种是商品突然下架，第二种是商品突然库存不够
    # 这两种情况都不会生成订单，而是重定向到订单确认页面后，由用户重新提交订单
    # 在订单确认页面，会对突然下架的商品进行处理，会显示出来，但不会计算进金额
    if current_cart.product_count > current_cart.real_product_count
      flash[:error] = '商品库存不够，无法生成订单, 请重新提交订单'
      redirect_to confirm_mall_orders_path
      return
    end

    # 在订单确认页面，会对库存不够的商品进行设置最大能购买的数量，并显示出来
    if current_cart.all_product_count > current_cart.product_count
      flash[:error] = '商品突然下架，下架的商品不能提交，请删除后请重新提交订单'
      redirect_to confirm_mall_orders_path
      return
    end

    if params[:activity_id].present? && params[:account].nil?
      flash[:error] = '参加活动，必须填写S币账号'
      redirect_to confirm_mall_orders_path
      return
    end

    line_items = current_cart.line_items.where(id: session[:line_item_ids])

    # 去掉库存为0的商品
    line_items = line_items.reject { |line_item| line_item.quantity == 0 }
    # 1. 计算金额(不包含下架的商品)
    price = line_items.to_a.sum { |item| item.total_price }
    # 2. 计算商品数量(不包含下架的商品)
    quantity = line_items.to_a.sum { |item| item.quantity }
    # 3. 生成订单
    @order = current_user.orders.new(
      address_id: params[:address_id],
      price: price,
      quantity: quantity,
      activity_id: params[:activity_id],
      account: params[:account],
      password: params[:password]
    )

    if @order.save
      # 4. 清空购物车已生成订单的商品
      line_items.each do |line_item|
        line_item.move_to_order(@order.id)
      end
      # 5. 清空session
      session[:line_item_ids] = nil
      # 6. 跳转到支付页面
      redirect_to pay_mall_order_path(@order)
    else
      logger.info @order.errors.messages
      flash[:success] = @order.errors.messages.values.join(",")
      redirect_to confirm_mall_orders_path(address_id: params[:address_id])
    end
  end

  def confirm
    @line_items = current_cart.line_items.where(id: session[:line_item_ids])
    @all_line_item_count =  @line_items.sum { |line_item| line_item.quantity }
    @total_price = @line_items.sum { |line_item| line_item.total_price }
    @recommend_address = current_user.addresses.find_by(id: params[:address_id]) || current_user.recommend_address
    @activities = Activity.all
    @scoin_account_id = ScoinAccount.where(user_id: current_user.user_id).take
  end

  def pay
    @no_fotter = true
    @order = current_user.orders.find(params[:id])
    @trade_merge_pay_params = @order.fast_pay.trade_merge_pay_params
  end

  def make_cancel
    @order = Order.find(params[:id])
    if @order.may_make_cancel?
      @order.make_cancel!
      flash[:notice] = "已取消订单!"
    else
      flash[:notice] = "操作失败!"
    end
  end
end
