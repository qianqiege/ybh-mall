class AddPlanIdToParallelShops < ActiveRecord::Migration[5.0]
  def change
    add_column :parallel_shops, :plan_id, :integer
  end
end
