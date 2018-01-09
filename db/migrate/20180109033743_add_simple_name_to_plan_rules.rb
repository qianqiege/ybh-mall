class AddSimpleNameToPlanRules < ActiveRecord::Migration[5.0]
  def change
  	add_column :plan_rules, :simple_name, :string
  end
end
