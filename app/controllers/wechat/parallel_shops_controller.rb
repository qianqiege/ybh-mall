class Wechat::ParallelShopsController < Wechat::BaseController
  def index
  	@slides = Slide.top(1)
  end

  def shopdata
    if !current_user.user_id.nil?
      @parallel_shop = ParallelShop.find_by(id:params[:format])
    else
      redirect_to '/user/binding'
    end
  end

  def commoditydetails

  end

  def pay
      @shop_order = ShopOrder.create(   wechat_user_id:current_user.id,
                                        total:      params[:total].to_f,
                                        status:     "pending",
                                        difference: params[:total].to_f,
                                        )
      params[:items].each do |key|
          ShopOrderItem.create( shop_order_id:  @shop_order.id,
                                product_id:     params[:items][key][:product_id].to_i,
                                amount:         params[:items][key][:count].to_i,
                                price:          Product.find_by(id:params[:items][key][:product_id].to_i).now_product_price,
                                sub_total:      params[:items][key][:count].to_i*Product.find_by(id:params[:items][key][:product_id].to_i).now_product_price)
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
    byebug
    # 获得顾客消费的金额
    if params[:con_money] != ""
      @con_money = params[:con_money]
    else
      redirect_to :back, notice: "请输入消费金额"
    end

    # 用户扫码后跳转到营业员对应平行店中
    url = wechat_parallel_shops_shopdata_url(current_user.user.parallel_shop_id)
    @code = RQRCode::QRCode.new(url, :size => 8, :level => :h)

  end

  def shopreceive

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
      redirect_to wechat_community_plandetail_path(params[:plan_id])
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
