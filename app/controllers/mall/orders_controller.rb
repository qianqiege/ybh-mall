class Mall::OrdersController < Mall::BaseController
  include BindPhone
  before_action :check_bind_phone, only: [:confirm, :create]
  include HasAddress
  before_action :check_has_address, only: [:confirm, :create]
  include CurrentCart
  before_action :check_cart, only: [:confirm]

  def express
    @order = Order.find(params[:id])
    express = @order.remote_express_info
    if express["status"].to_i == 200
      @express_data = express["data"]
    end
  end

  def index
    #在商城中删除的产品放入一个数组
    @delete_product = [9,10,12,14,15,16,17,18,19,20,21,22,25,40,48,61]
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

    line_items = current_cart.line_items.where(id: session[:line_item_ids])

    # 去掉库存为0的商品
    line_items = line_items.reject { |line_item| line_item.quantity == 0 }
    # 1. 计算金额(不包含下架的商品)
    price = line_items.to_a.sum { |item| item.total_price }
    # 2. 计算商品数量(不包含下架的商品)
    quantity = line_items.to_a.sum { |item| item.quantity }


    integral_available = params["integral_available"].to_f
    integral_money = params["integral_money"].to_f
    celebrate_ratsimp = params["celebrate_ratsimp"].to_f/10

    # 使用优惠券
    if params[:lottery_prize_id].present?
      lottery = LotteryPrize.find(UserPrize.find(params[:lottery_prize_id]).lottery_prize_id)
      price = price * lottery.welfare.to_f
    end

    # 自定义价格
    # 这里会减去 使用积分， 现金余额， 庆通分
    if params[:custom_price].present?
      price = params[:custom_price].to_f - (integral_money + integral_available + celebrate_ratsimp)
    else
      if integral_money.present? && integral_available.present? && celebrate_ratsimp.present?
        price = price - (integral_money + integral_available + celebrate_ratsimp)
      end
    end

    activity = 0

    line_items.each do |item|
      if item.product_id == 1
        activity = 13
      elsif item.product_id == 38
        activity = 13
      elsif item.product_id == 50
        activity = 13
      else
        activity = params[:activity_id]
      end
    end

    # 3. 生成订单
    @order = current_user.orders.new(
      address_id: params[:address_id],
      price: price,
      quantity: quantity,
      activity_id: activity,
      password: params[:password],
      payment: params[:payment],
      is_handle: false,
      # is_donation: donation
    )

    if params[:lottery_prize_id].present?
      @order.lottery_prize_id = LotteryPrize.find(UserPrize.find(params[:lottery_prize_id]).lottery_prize_id).id
    end

    if activity.to_i == 12
      if price >= 5000
        @order.evaluation_number = price / 5000
      else
        @order.evaluation_number = 1
      end
    end

    if session[:programs_number].present?
      @order.programs_number = session[:programs_number]
    end

    if params[:account].present?
      @order.account = params[:account]
    end

    if !integral_money.nil? && !integral_available.nil? && !celebrate_ratsimp.nil?
      @order.cash = integral_money
      @order.integral = integral_available
      @order.celebrate_ratsimp = celebrate_ratsimp*10
    else
      @order.cash = 0
      @order.integral = 0
      @order.celebrate_ratsimp = 0
    end

    @order.desc = params[:custom_desc]
    @order.is_ybz = 1

    if @order.save
      # 4. 清空购物车已生成订单的商品
      line_items.each do |line_item|
        line_item.move_to_order(@order.id) if line_item.cart_id == current_cart.id
        if !line_item.product.height.nil? && line_item.product_id != 55 && line_item.product_id != 56
          HightTicket.create(user_id: current_user.user_id, number: 1,state: "panding",order_id: @order.id)
        elsif !line_item.product.height.nil? && line_item.product_id == 55 || line_item.product_id == 56
          i = 1
          while i <= 2
            HightTicket.create(user_id: current_user.user_id, number: 1,state: "panding",order_id: @order.id)
            i = i + 1
          end
        end
      end

      # 5. 清空session
      session[:line_item_ids] = nil
      if params["payment"] != "PAYMENT_TYPE_NULL"
        # 6. 跳转到支付页面
        redirect_to pay_mall_order_path(@order)
      else
        flash[:notice] = "已完成订单，等待工作人员确认收款!"
        redirect_to mall_my_path
      end
    else
      logger.info @order.errors.messages
      flash[:success] = @order.errors.messages.values.join(",")
      redirect_to confirm_mall_orders_path(address_id: params[:address_id])
    end
  end

  def confirm
    @line_items = current_cart.line_items.where(id: session[:line_item_ids])

    @line_items.each do |line_item|
      if line_item.product.name.match(/点亮心灯/)
        if !line_item.product.height.nil? && line_item.product_id != 55 && line_item.product_id != 56
          @product_ticket_number = @product_ticket_number.to_i + line_item.quantity.to_i
        elsif !line_item.product.height.nil? && line_item.product_id == 55 || line_item.product_id == 56
          @programs_ticket_number = @programs_ticket_number.to_i + line_item.quantity.to_i * 2
        end
      end
    end
    @all_line_item_count =  @line_items.sum { |line_item| line_item.quantity }
    @total_price = @line_items.sum { |line_item| line_item.total_price }
    @recommend_address = current_user.addresses.find_by(id: params[:address_id]) || current_user.recommend_address
    @activities = Activity.where(is_show: true)
    if Integral.find_by(user_id: current_user.user_id)
      @integral = Integral.find_by(user_id: current_user.user_id)
    end
    @activity = Product.find(@line_items.pluck(:product_id)).pluck(:activity_id)
    @lotterys = UserPrize.where(user_id: current_user.user_id,state: 'pending')

    # 判断 非测试人员 不展示测试活动
    if current_user.user.is_test == false
        @activities = @activities.where(is_test: false)
    end

  end

  def pay
    @no_fotter = true
    @order = current_user.orders.find(params[:id])
    @trade_merge_pay_params = @order.fast_pay.trade_merge_pay_params(@order.payment)
  end

  def exchange_pay
    @no_fotter = true
    @order = Order.find(params["format"])
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

  def receive
    @order = Order.find(params[:id])
    if @order.may_receive?
      @order.receive!
      flash[:notice] = "设置成功!"
    else
      flash[:notice] = "操作失败!"
    end
  end
end
