class AddAdminUserIdToParallelShops < ActiveRecord::Migration[5.0]
  def change
    add_column :parallel_shops, :admin_user_id, :integer
  end
end
