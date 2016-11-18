class ChangeShopCountToIntegerFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :shop_count
    add_column :products, :shop_count, :integer, default: 0
  end
end
