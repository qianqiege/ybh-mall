class AddParallelShopIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :parallel_shop_id, :integer
  end
end
