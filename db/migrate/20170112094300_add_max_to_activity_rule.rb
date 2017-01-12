class AddMaxToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :max, :decimal
    add_column :activity_rules, :min, :decimal
    add_column :activity_rules, :y_coin, :decimal
    add_column :activity_rules, :scoin_type, :string
  end
end
