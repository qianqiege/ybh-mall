class AddTypeToPlanRules < ActiveRecord::Migration[5.0]
  def change
      add_column :plan_rules, :plan_type, :string
  end
end
