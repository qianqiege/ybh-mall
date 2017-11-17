class AddCashToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :cash, :decimal,precision: 10, scale: 3
  end
end
