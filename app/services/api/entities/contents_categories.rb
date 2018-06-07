module Entities
  class ContentsCategories < Grape::Entity
    present_collection true, :data
    expose :data, using: ::Entities::ContentsCategory
  end
end