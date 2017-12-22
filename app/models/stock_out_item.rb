class StockOutItem < ApplicationRecord
    belongs_to :stock_out
    belongs_to :product

    def sub_total
        self.product.now_product_price*self.amount
    end
end
