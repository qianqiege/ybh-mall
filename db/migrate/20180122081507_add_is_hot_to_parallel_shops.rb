class AddIsHotToParallelShops < ActiveRecord::Migration[5.0]
  def change
    add_column :parallel_shops, :is_hot, :boolean
  end
end
