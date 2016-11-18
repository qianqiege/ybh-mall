class ChangeShopCountToIntegerFromProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :shop_count, :integer
  end
end
