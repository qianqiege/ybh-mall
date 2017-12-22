class PurchaseOrder < ApplicationRecord
    belongs_to :parallel_shop
    has_many :purchase_order_items
    has_many :stock_outs
    accepts_nested_attributes_for :purchase_order_items, allow_destroy: true
    before_save :change_number

    after_update :create_stock_out

    def create_stock_out
        if self.state == "dealed"
            t = StockOut.create(purchase_order_id:  self.id,
                                parallel_shop_id:   self.parallel_shop_id,
                                )
            self.purchase_order_items.each do |a|
                StockOutItem.create(stock_out_id:t.id,
                                    product_id:a.product_id,
                                    amount:a.amount)
            end
        end
    end


    def self.generate_number
      loop do
        salt = rand(99999..999999)
        coding = "CG"+"#{Date.current.to_s(:number)}#{salt}"
        break coding unless self.exists?(number: coding)
      end
    end

    def change_number
        self.number = PurchaseOrder.generate_number
    end

    include AASM
    aasm column: :state do
      # 待付款，初始状态
      state :pending, initial: true
      state :dealed

      event :deal do
          transitions from: :pending, to: :dealed
          after do
              self.save
          end
      end
    end

    def total
        a = 0
        self.purchase_order_items.each do |t|
            a += t.product.now_product_price*t.amount
        end
        return a
    end

    def name
        self.number
    end
end
