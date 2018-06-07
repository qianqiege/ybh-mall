module Entities
  class ContentsCategories < Grape::Entity
    present_collection true, :contents
    unexpose :second_category
    expose :contents, as: :data, using: ::Entities::ContentsCategory
  end
end