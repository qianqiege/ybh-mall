module Entities
  class Products < Grape::Entity
    present_collection true, :products
    expose :products, as: :data, using: ::Entities::Product
  end
end