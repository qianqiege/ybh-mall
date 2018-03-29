class Mall::HomeController < Mall::BaseController
  def index
    @slides = Slide.top(2)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).select("image,name,general,now_product_price,original_product_price,is_test,priority,display,id").where(display: true).order("priority DESC, id DESC")
    if !params[:id].nil?
      @products = @q.result(distinct: true).where(display: true,is_show: true,height: "一盏明灯")
      @slides = Slide.top(9)
    end
    @id = params[:id]

    # 判断用户不是测试人员时， 筛选非测试产品
    if current_user.user && current_user.user.is_test == false
      @products = @products.where(is_test: false, contents_category_id: ContentsCategory.find(1).downs)
    end
    @first_categorys = ContentsCategory.where(up_id: nil, is_display: true)
  end

  def classify
  	@q = Product.ransack(params[:q])
  	@products = @q.result(distinct: true).select("image,name,general,now_product_price,original_product_price,is_test,priority,display,id").where(display: true).order("priority DESC, id DESC")
    @programs = Program.where(is_show: true)
  end
end
