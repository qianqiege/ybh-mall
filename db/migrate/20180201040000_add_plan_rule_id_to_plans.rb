class AddPlanRuleIdToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :plan_rule_id, :integer
  end
end
