class AddColumnsToActivityRules < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :percent, :decimal,:precision => 10,:scale=>2
  end
end
