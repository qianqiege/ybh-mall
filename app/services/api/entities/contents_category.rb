module Entities
  class ContentsCategory < Model
    expose :name
    expose :up_id
    expose :is_display
    expose :order
    expose :second_category, using: ::Entities::ContentsCategories
    expose :contant_product, as: :product, using: ::Entities::Products

    private

    def second_category
      object.downs
    end

    def contant_product
      object.products.where(is_show: 1)
    end
  end
end
