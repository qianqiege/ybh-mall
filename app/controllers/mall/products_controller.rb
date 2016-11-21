class Mall::ProductsController < Mall::BaseController
  before_action :set_product, :store_location, only: [:show]
  include CurrentCart
  before_action :check_cart_product_count, only: [:show]

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
