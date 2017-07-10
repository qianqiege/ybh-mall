class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).where(is_show: true).order("priority DESC, id DESC")
  end

  def classify
  	@q = Product.ransack(params[:q])
  	@products = @q.result(distinct: true).where(is_show: true).order("priority DESC, id DESC")
    @product1 = @products.where(sort: 1)
    @product2 = @products.where(sort: 2)
    @product3 = @products.where(sort: 3)

    @programs = Program.where(is_show: true)
  end
end
