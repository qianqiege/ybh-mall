class Web::MallController < Web::BaseController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).where(is_show: true).order("id DESC")
  end
end
