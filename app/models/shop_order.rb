class ShopOrder < ApplicationRecord
    belongs_to :user
    has_many :shop_order_items
    accepts_nested_attributes_for :shop_order_items, allow_destroy:true
    after_update :update_amount

    def update_amount
        self.shop_order_items.each do |t|
            a = Stock.find_by(product_id:t.product_id, parallel_shop_id:self.user.parallel_shop_id)
            a.amount -= t.amount
            a.save
        end
    end

    def total
        a = 0
        self.shop_order_items.each do |t|
            a += t.product.now_product_price*t.amount
        end
        return a
    end

    def difference
        self.total - self.shop_pay
    end


end
