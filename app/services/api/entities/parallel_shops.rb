module Entities
  class ParallelShops < ResourcesCollection
    present_collection true, :entries
    expose :entries, as: :data, using: ::Entities::ParallelShop
  end
end