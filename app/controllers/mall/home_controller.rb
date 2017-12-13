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

    # 判断用户不是测试人员时， 筛选非测试产品
    if current_user.user.is_test == false
      @products = @products.where(is_test: false)
    end
  end

  def classify
  	@q = Product.ransack(params[:q])
  	@products = @q.result(distinct: true).where(display: true).order("priority DESC, id DESC")
    @programs = Program.where(is_show: true)
  end
end
