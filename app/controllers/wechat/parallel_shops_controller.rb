class Wechat::ParallelShopsController < Wechat::BaseController
  def index
  	@slides = Slide.top(1)
  end

  def shopdata
    # 判断当前顾客是否注册
    # 注册了，则直接跳转到营业员所在的平行店
    # 未注册， 跳转到注册页面
    # params[:waiter_id]  传入的是 营业员id
    if !current_user.user_id.nil?

      # 如果流程是 顾客自己从首页进入平行店  走true判断
      # 若流程是 顾客扫描营业员二维码进入  走elsif流程
      # elsif 流程  提供营业员@waiter  店内消费金额@money
      if !params[:format].nil?
        @parallel_shop = ParallelShop.find(params[:format])
      elsif params[:waiter_id] && params[:money]
          @money = params[:money]
          @waiter = User.find(params[:waiter_id])
          @parallel_shop = ParallelShop.find_by(id: @waiter.parallel_shop_id)
      end

    else
      redirect_to user_binding_path(waiter_id: params[:waiter_id], money: params[:money])
    end
  end

  def commoditydetails

  end

  def collective

      # 从营业员扫码流程 平行领配 
      # 订单初始状态为 "pending"
      # 经过"配货"动作后， 将状态改为 "finished"
      @shop_order = ShopOrder.create(   wechat_user_id:     current_user.id,
                                        total:              params[:total].to_f,
                                        status:             "pending",
                                        difference:         params[:total].to_f,
                                        user_id:            params[:waiter_id].to_i,
                                        parallel_shop_id:   User.find_by(id:params[:waiter_id].to_i).parallel_shop_id
                                        )


      params[:items].keys.each do |key|
        ShopOrderItem.create(           shop_order_id:      @shop_order.id,
                                        product_id:         params[:items][key]["product_id"].to_i,
                                        amount:             params[:items][key]["amount"].to_i,
                                        price:              params[:items][key]["price"].to_f,
                                        sub_total:          params[:items][key]["amount"].to_i*params[:items][key]["price"].to_f)
      end


  end

  def pay
      @shop_order = ShopOrder.create(   wechat_user_id:     current_user.id,
                                        total:              params[:total].to_f,
                                        status:             "pending",
                                        difference:         params[:total].to_f,
                                        )
      params[:items].each do |key|
          ShopOrderItem.create(         shop_order_id:      @shop_order.id,
                                        product_id:         params[:items][key][:product_id].to_i,
                                        amount:             params[:items][key][:count].to_i,
                                        price:              Product.find_by(id:params[:items][key][:product_id].to_i).now_product_price,
                                        sub_total:          params[:items][key][:count].to_i*Product.find_by(id:params[:items][key][:product_id].to_i).now_product_price)
      end
  end

  def code
    @shop_order = ShopOrder.where(wechat_user_id:current_user.id).last
    #   二維碼方法
    url = wechat_parallel_shops_waiter_url(@shop_order)
    @code = RQRCode::QRCode.new(url, :size => 8, :level => :h)
  end

  def waiter
    @shop_user =  User.find_by(id: current_user.user.id)
    if current_user.user.parallel_shop_id
      @message = "您没有此权限"
    else
      @shop_order = ShopOrder.find(params[:format])
      @shop_order_items = @shop_order.shop_order_items
    end
  end

  # 营业员输入消费金额页面
  def waiter_input_money

  end

  # 店铺营业员二维码
  def waiter_code
    # 获得顾客消费的金额
    if params[:con_money] != ""
      @con_money = params[:con_money]
    else
      redirect_to :back, notice: "请输入消费金额"
    end

    # 用户扫码后跳转到营业员对应平行店中
    url = wechat_parallel_shops_shopdata_url(money: params[:con_money], waiter_id: current_user.user.id)
    @code = RQRCode::QRCode.new(url, :size => 8, :level => :h)

  end

  def shopreceive
    # 用户扫描营业员二维码 平行配领成功
    # 获取该用户最后一条订单
    @shop_order = ShopOrder.where(wechat_user_id: current_user.id).last

    @shop_order_items = @shop_order.shop_order_items


    url = root_url
    @code = RQRCode::QRCode.new(url, :size => 8, :level => :h)
  end

  def instructions

  end

  def salesclerk

  end

  def shopindex

  end

  def partners

  end

  def applyshop
    @shop = ParallelShop.new
  end

  def shop_pay
      @shop_order = ShopOrder.find_by(id:params[:id])
      @shop_order.shop_pay = params[:shop_pay].to_f
      @shop_order.difference = @shop_order.total - params[:shop_pay].to_f
      if @shop_order.difference > 0
          @shop_order.save
          render text: @shop_order.difference
      else
          @shop_order.status = "finished"
          @shop_order.save
          render text: "支付成功！"
      end
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @shop = @plan.parallel_shops.new(shop_params)

    admin_data = {
      email: params[:admin_email],
      password: params[:admin_password],
      role_name: 'parallel_shop'
    }

    if @shop.save
      # 在创建平行店后，创建adminuser用户
      @admin_user = AdminUser.create(admin_data)
      @shop.update!(admin_user_id: @admin_user.id)

      flash[:success] = '平行店创建成功'

      # 判断计划为 199 或者 创客计划
      if @plan.is_maker == true
        redirect_to wechat_makers_plan_details_path(params[:plan_id])
      else
        redirect_to wechat_community_plandetail_path(params[:plan_id])
      end

      
    else
      render 'applyshop'
    end

  end


  private
   def shop_params
    params.require(:parallel_shop).permit(:title,
                                    :province,
                                    :city,
                                    :street,
                                    :main_business,
                                    :detail)
  end

end
