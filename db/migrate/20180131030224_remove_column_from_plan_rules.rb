class RemoveColumnFromPlanRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :plan_rules, :invite_count, :integer
    remove_column :plan_rules, :plan_type, :string
    remove_column :plan_rules, :link, :string
  end
end
