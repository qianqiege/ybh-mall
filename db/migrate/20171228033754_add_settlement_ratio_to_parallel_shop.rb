class AddSettlementRatioToParallelShop < ActiveRecord::Migration[5.0]
  def change
      add_column :parallel_shops, :settlement_ratio, :float
      add_column :parallel_shops, :earning_ratio, :float
  end
end
