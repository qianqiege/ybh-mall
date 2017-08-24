class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).where(display: true).order("priority DESC, id DESC")
    if !params[:id].nil?
      @products = @q.result(distinct: true).where(display: false,is_show: true,height: "一盏明灯")
    end
  end

  def classify
  	@q = Product.ransack(params[:q])
  	@products = @q.result(distinct: true).where(display: true).order("priority DESC, id DESC")
    @product1 = @products.where(sort: 1)
    @product2 = @products.where(sort: 2)
    @product3 = @products.where(sort: 3)

    @programs = Program.where(is_show: true)
  end
end
