class Work::HomeController < Wechat::BaseController
  def index
    @slides = Slide.top(1)
    @shop = Shop.order(number: :desc).limit(10)
    @shop_image = ShopPropagandaImage.where(shop_id: @shop.pluck(:id))
  end
end
