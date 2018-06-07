module Entities
  class ContentsCategories < Grape::Entity
    present_collection true, :entries
    expose :entries, as: :data, using: ::Entities::ContentsCategory
  end
end