class SaleProduct < ApplicationRecord
    belongs_to :product
    belongs_to :parallel_shop
end
