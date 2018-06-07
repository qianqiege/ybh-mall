module Entities
  class ContentsCategory < Model
    expose :name
    expose :up_id
    expose :is_display
    expose :order
    expose :second_category, using: ::Entities::ContentsCategories
    expose :all_products, as: :product, using: ::Entities::Products

  end
end
