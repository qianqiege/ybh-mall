class ShopPropagandaImage < ApplicationRecord
	include ImageConcern 
	belongs_to :shop
end
