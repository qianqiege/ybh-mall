class RemoveEarningRatioFromParallelShop < ActiveRecord::Migration[5.0]
  def change
      remove_column :parallel_shops, :earning_ratio, :float
      add_column :plan_rules, :earning_ratio, :float, default: 0.05
  end
end
