class AddParallelShopRevenueToPlanRules < ActiveRecord::Migration[5.0]
  def change
    add_column :plan_rules, :parallel_shop_revenue, :float
  end
end
