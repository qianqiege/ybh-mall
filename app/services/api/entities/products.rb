module Entities
  class Products < Grape::Entity
    present_collection true, :entries
    expose :entries, as: :data, using: ::Entities::Product
  end
end