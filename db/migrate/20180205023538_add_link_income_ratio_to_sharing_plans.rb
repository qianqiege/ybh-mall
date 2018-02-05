class AddLinkIncomeRatioToSharingPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :sharing_plans, :link_income_ratio, :float
    add_column :sharing_plans, :product_ratio, :float
  end
end
