class RemoveInstructionFromPlanRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :plan_rules, :instruction, :text
  end
end
