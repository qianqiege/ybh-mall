class AddShopRevenueToPlanRules < ActiveRecord::Migration[5.0]
  def change
    add_column :plan_rules, :shop_revenue, :float
  end
end
