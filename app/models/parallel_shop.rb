class ParallelShop < ApplicationRecord
    has_many :purchase_orders
    has_many :stock_outs
    has_many :day_deals
    has_many :month_deal
    has_many :stock
end
