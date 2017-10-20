class Work::HomeController < Wechat::BaseController
  def index
  	if current_user.user.status != "Staff"
  	   redirect_to :back, notice: "只有健康管理师才能访问该模板的权限!"
  	end
    @slides = Slide.top(1)
    @shop = Shop.order(number: :desc).limit(10)
    @shop_image = ShopPropagandaImage.where(shop_id: @shop.pluck(:id))
  end
end
