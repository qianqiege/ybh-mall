class RemoveSimpleNameFromPlanRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :plan_rules, :simple_name, :string
  end
end
