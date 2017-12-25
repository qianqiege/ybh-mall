class Wechat::ParallelShopsController < Wechat::BaseController
  def index
  	@slides = Slide.top(1)
  end

  def shopdata
  	@parallel_shop = ParallelShop.find_by(id:params[:format])
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
    if !@shop_user
      @message = "您没有此权限"
    else
      @shop_order = ShopOrder.find(params[:format])
      @shop_order_items = @shop_order.shop_order_items
    end
  end

  def shopreceive

  end

  def instructions

  end

  def salesclerk

  end

  def partners

  end

  def applyshop
    @shop = ParallelShop.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @shop = @plan.parallel_shops.new(shop_params)
    if @shop.save
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
