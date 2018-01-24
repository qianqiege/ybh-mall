class MoneyDetail < ApplicationRecord
  belongs_to :user
  belongs_to :shop_order
  belongs_to :plan
  after_create :update_plan_money

  def update_plan_money
    plan.money += money
    plan.save
  end
end
