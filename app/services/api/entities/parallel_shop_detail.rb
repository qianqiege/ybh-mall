module Entities
  class ParallelShopDetail < Grape::Entity
    present_collection true, :data
    expose :data, using: ::Entities::ParallelShop
  end
end