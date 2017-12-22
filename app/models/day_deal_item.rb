class DayDealItem < ApplicationRecord
    belongs_to :product
    belongs_to :day_deal

    def price
        self.product.now_product_price
    end

    def sub_total
        self.product.now_product_price*self.amount
    end
end
