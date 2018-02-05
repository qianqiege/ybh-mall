class AddInstructionToPlanRules < ActiveRecord::Migration[5.0]
  def change
    add_column :plan_rules, :instruction, :text
    add_column :plan_rules, :shop_revenue, :text
  end
end
