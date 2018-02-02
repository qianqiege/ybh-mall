class AddEarningRatioToSharingPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :sharing_plans, :earning_ratio, :float
  end
end
