class AddUserIdToParallelShops < ActiveRecord::Migration[5.0]
  def change
      add_column :parallel_shops, :user_id, :integer
  end
end
