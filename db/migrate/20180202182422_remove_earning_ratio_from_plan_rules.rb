class RemoveEarningRatioFromPlanRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :plan_rules, :earning_ratio, :float
  end
end
