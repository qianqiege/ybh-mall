class MoneyDetail < ApplicationRecord
    belongs_to :user
    belongs_to :shop_order
end
