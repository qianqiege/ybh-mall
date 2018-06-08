module Entities
  class ContentsCategory < Model
    expose :name
    expose :up_id
    expose :is_display
    expose :order
    expose :second_category, using: ::Entities::ContentsCategories do |instance, option|
    	instance.try(:downs)
    end
    expose :products, as: :product, using: ::Entities::Products do |instance, option|
    	instance.try(:products).where(is_show: 1)
  	end
  end
end
