class MoneyDetail < ApplicationRecord
    belongs_to :user
    belongs_to :shop_order
    belongs_to :plan
    after_create :create_money_detail

    def create_money_detail
        if self.plan.invite_plan_id
            t = Plan.find_by(id:self.plan.invite_plan_id)
            if t.invite_plan_id
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
        f = self.plan
        f.money += self.money
        f.save
    end
end
