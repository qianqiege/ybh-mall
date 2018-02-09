class ValueableProduct::ValueableProductsController < ApplicationController
	layout "valueable"
	def index
		@slides = Slide.top(1)
		@valueable_products = ValueableProduct.all()
		@categories= ContentsCategory.find_by_name("保值产品").downs
	end

	def classified
		@valueable_products = ContentsCategory.find(params[:id]).valueable_products
		render partial: "/valueable_product/valueable_products/products_list"
	end
end
