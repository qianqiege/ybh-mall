module Entities
  class ParallelShopDetail < Grape::Entity
    present_collection true, :entries
    expose :entries, as: :data, using: ::Entities::ParallelShop
  end
end