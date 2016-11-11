class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @products = Product.where(is_show: true)
  end
end
