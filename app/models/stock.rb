class Stock < ApplicationRecord
    belongs_to :parallel_shop
    belongs_to :product
end
