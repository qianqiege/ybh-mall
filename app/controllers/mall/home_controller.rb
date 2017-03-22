class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).where(is_show: true).order("weight DESC, id DESC")
  end
end
