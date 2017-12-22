class MonthDeal < ApplicationRecord
    belongs_to :parallel_shop
    has_many :month_deal_items
    accepts_nested_attributes_for :month_deal_items, allow_destroy:true
    after_update :create_month_deal

    def create_month_deal
        if self.status == "ending"
            MonthDeal.create( parallel_shop_id:self.parallel_shop_id)
        end
    end

    include AASM
    aasm column: :status do
      state :pending, initial: true
      state :ending

      event :deal do
          transitions from: :pending, to: :ending
          after do
              self.save
          end
      end
    end

    def should_pay
        a = 0
        self.month_deal_items.each do |t|
            a += t.amount*t.price
        end
        return a
    end
end
