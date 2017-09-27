class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).where(display: true).order("priority DESC, id DESC")
    if !params[:id].nil?
      @products = @q.result(distinct: true).where(display: true,is_show: true,height: "一盏明灯")
      @slides = Slide.top(9)
    end
    @id = params[:id]
  end

  def classify
  	@q = Product.ransack(params[:q])
  	@products = @q.result(distinct: true).where(display: true).order("priority DESC, id DESC")
    @programs = Program.where(is_show: true)
  end
end
