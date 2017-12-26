class RemoveParallelShopIdFromAdminUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :admin_users, :parallel_shop_id, :integer
  end
end
