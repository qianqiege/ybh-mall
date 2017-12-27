class MoneyDetail < ApplicationRecord
    belongs_to :user
    belongs_to :shop_order
    belongs_to :plan
    after_create :create_money_detail

    def create_money_detail
        t = Plan.find_by(user_id:self.plan.capital_id, capital_id:nil)
        if t
            MoneyDetail.create( user_id:        self.plan.capital_id,
                                plan_id:        t.id,
                                shop_order_id:  self.shop_order_id,
                                reason:         "队长操心费",
                                money:          self.money/10
                                )
        else
            MoneyDetail.create( user_id:        self.plan.capital_id,
                                plan_id:        t.id,
                                shop_order_id:  self.shop_order_id,
                                reason:         "队长操心费",
                                money:          self.money/9
                                )
        end
    end
end
