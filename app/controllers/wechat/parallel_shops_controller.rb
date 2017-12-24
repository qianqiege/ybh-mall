class Wechat::ParallelShopsController < Wechat::BaseController
  def index
  	@slides = Slide.top(1)
  end

  def shopdata
  	
  end

  def commoditydetails
	
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
    if @shop.save!
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
