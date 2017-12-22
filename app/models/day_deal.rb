class DayDeal < ApplicationRecord
    belongs_to :parallel_shop
    has_many :day_deal_items
    accepts_nested_attributes_for :day_deal_items, allow_destroy:true
    after_update :create_day_deal

    def create_day_deal
        if self.status == "ending"
            DayDeal.create( parallel_shop_id:self.parallel_shop_id)
            t = MonthDeal.where( parallel_shop_id:self.parallel_shop_id).last
            t.already_pay += self.should_pay
            t.save
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
        self.day_deal_items.each do |t|
            a += t.amount*t.price
        end
        return a
    end
end
