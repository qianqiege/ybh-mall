class AddParallelShopIdToSpdBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_businesses, :parallel_shop_id, :integer
  end
end
