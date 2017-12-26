class AddParallelShopIdToAdminUser < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :parallel_shop_id, :integer
  end
end
