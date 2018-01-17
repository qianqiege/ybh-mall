class AddLedAwayCategoryToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :led_away_category, :string
  end
end
