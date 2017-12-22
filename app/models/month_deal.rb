class MonthDeal < ApplicationRecord
    belongs_to :parallel_shop
    has_many :month_deal_items
    accepts_nested_attributes_for :month_deal_items, allow_destroy:true

    def should_pay
        a = 0
        self.month_deal_items.each do |t|
            a += t.amount*t.price
        end
        return a
    end
end
