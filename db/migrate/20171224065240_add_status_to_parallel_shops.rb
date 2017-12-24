class AddStatusToParallelShops < ActiveRecord::Migration[5.0]
  def change
    add_column :parallel_shops, :status, :string, default: 'waiting'
  end
end
