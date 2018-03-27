class AddShopTypeToParallelShop < ActiveRecord::Migration[5.0]
  def change
  	add_column :parallel_shops, :shop_type, :string
  end
end
