module Entities
  class Products < Grape::Entity
    present_collection true, :data
    expose :data, using: ::Entities::Product
  end
end