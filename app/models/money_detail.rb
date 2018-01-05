class MoneyDetail < ApplicationRecord
    belongs_to :user
    belongs_to :shop_order
    belongs_to :plan
    after_create :update_plan_money, :create_money_detail

    def update_plan_money
        a = self.plan
        a.money += self.money
        a.save
    end

    # 确认下逻辑是否正确
    def create_money_detail
        t = Plan.where(user_id:self.plan.user_id).where.not(invite_plan_id:nil)
        if !t.blank?
            f = Plan.where(user_id:t[0].capital_id).where.not(invite_plan_id:nil)
            if !f.blank?
                MoneyDetail.create( user_id:        t[0].capital_id,
                                    plan_id:        t[0].invite_plan_id,
                                    shop_order_id:  self.shop_order_id,
                                    reason:         "队长操心费",
                                    money:          self.money/10
                                    )
            else
                MoneyDetail.create( user_id:        t[0].capital_id,
                                    plan_id:        t[0].invite_plan_id,
                                    shop_order_id:  self.shop_order_id,
                                    reason:         "队长操心费",
                                    money:          self.money/9
                                    )
            end
        end
    end
end
