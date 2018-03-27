class AddLeftAndRightRatioToParallelShop < ActiveRecord::Migration[5.0]
  def change
  	add_column :parallel_shops, :left_and_right_ratio, :float
  end
end
