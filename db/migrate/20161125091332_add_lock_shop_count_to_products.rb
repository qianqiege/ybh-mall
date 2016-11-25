class AddLockShopCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :lock_shop_count, :integer, default: 0
  end
end
