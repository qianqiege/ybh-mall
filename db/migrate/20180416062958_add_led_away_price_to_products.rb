class AddLedAwayPriceToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :led_away_price, :decimal, precision: 16, scale: 2
    add_column :products, :led_away_coefficient_id, :integer

  end
end
