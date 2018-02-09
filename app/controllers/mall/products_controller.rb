class Mall::ProductsController < Mall::BaseController
  before_action :set_product, :store_location, only: [:show]
  include CurrentCart
  before_action :check_cart, only: [:show]

  def show
    @no_fotter = true
    @slides = ProductImage.where(product_id: params[:id])
  end

  def classified
    @products = Product.where(contents_category_id: params[:id], display: true, is_test: false).order("priority DESC, id DESC")
    render partial: '/mall/home/product_classified'
  end

  def second_content
    @second_category = ContentsCategory.find(params[:id]).downs.where(is_display: true)
    render partial: '/mall/home/second_content'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
