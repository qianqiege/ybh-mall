class Mall::ProductsController < Mall::BaseController
  before_action :set_product, :store_location, only: [:show]
  include CurrentCart
  before_action :check_cart, only: [:show]

  def show
    @no_fotter = true
    @slides = ProductImage.where(product_id: params[:id])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
