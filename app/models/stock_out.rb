class StockOut < ApplicationRecord
    belongs_to :parallel_shop
    belongs_to :purchase_order
    has_many :stock_out_items
    accepts_nested_attributes_for :stock_out_items, allow_destroy:true
    after_update :update_stock
    before_save :change_number

    def change_number
        self.number = StockOut.generate_number
    end


    def self.generate_number
      loop do
        salt = rand(99999..999999)
        coding = "CK"+"#{Date.current.to_s(:number)}#{salt}"
        break coding unless self.exists?(number: coding)
      end
    end

    def update_stock
        if self.status == "finished"
            self.stock_out_items.each do |f|
                t = Stock.find_by(parallel_shop_id:self.parallel_shop_id,product_id:f.product_id)
                if t
                    t.amount += f.amount
                    t.save
                else
                    Stock.create(parallel_shop_id:self.parallel_shop_id, product_id:f.product_id, amount:f.amount)
                end
            end
        end
    end

    include AASM
    aasm column: :status do
      state :pending, initial: true
      state :sending
      state :finished

      event :deal do
          transitions from: :pending, to: :sending
          after do
              self.save
          end
      end
      event :sending do
          transitions from: :sending, to: :finished
          after do
              self.save
          end
      end
    end

    def total
        a= 0
        self.stock_out_items.each do |t|
            a += t.product.now_product_price*t.amount
        end
        return a
    end

    def parallel_shop
        self.purchase_order.parallel_shop
    end

    def contact
        self.purchase_order.contact
    end

    def address
        self.purchase_order.address
    end

    def phone
        self.purchase_order.phone
    end
end
