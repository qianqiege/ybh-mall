class DayDeal < ApplicationRecord
    belongs_to :parallel_shop
    has_many :day_deal_items
    accepts_nested_attributes_for :day_deal_items, allow_destroy:true

    def should_pay
        a = 0
        self.day_deal_items.each do |t|
            a += t.amount*t.price
        end
        return a
    end
end
