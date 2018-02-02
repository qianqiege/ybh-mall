class AddSharingPlanIdToPlanRules < ActiveRecord::Migration[5.0]
  def change
    add_column :plan_rules, :sharing_plan_id, :integer
  end
end
