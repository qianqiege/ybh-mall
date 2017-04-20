class AddBronzeToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :bronze, :decimal, precision: 10, scale: 2
    add_column :activity_rules, :silver, :decimal, precision: 10, scale: 2
    add_column :activity_rules, :gold, :decimal, precision: 10, scale: 2
  end
end
