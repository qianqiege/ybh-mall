class MonthDealItem < ApplicationRecord
    belongs_to :month_deal
    belongs_to :product

    def price
        self.product.now_product_price
    end

    def sub_total
        self.product.now_product_price*self.amount
    end
end
