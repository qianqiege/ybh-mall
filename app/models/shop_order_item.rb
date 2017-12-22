class ShopOrderItem < ApplicationRecord
    belongs_to :shop_order
    belongs_to :product

    def sub_total
        self.product.now_product_price*self.amount
    end
end
