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
      @shop_order = ShopOrder.create(   customer_id:Customer.find_by(phone:current_user.user.telphone).id,
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
    @shop = current_user.user.parallel_shops.new(shop_params)
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
