class AddIsCustomPriceToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_custom_price, :boolean, default: false
  end
end
