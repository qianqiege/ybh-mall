class Mall::ProductsController < Mall::BaseController
  before_action :set_product, only: [:show]
  before_action :store_location, only: [:show]

  def show
    @no_fotter = true
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
