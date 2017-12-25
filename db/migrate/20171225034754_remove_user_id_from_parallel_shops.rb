class RemoveUserIdFromParallelShops < ActiveRecord::Migration[5.0]
  def change
  	remove_column :parallel_shops, :user_id
  end
end
