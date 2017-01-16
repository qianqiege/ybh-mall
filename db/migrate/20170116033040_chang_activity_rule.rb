class ChangActivityRule < ActiveRecord::Migration[5.0]
  def change
    change_column :activity_rules, :max, :decimal,:precision => 10,:scale=>3
    change_column :activity_rules, :min, :decimal,:precision => 10,:scale=>3
  end
end
