class AddContractToSharingPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :sharing_plans, :contract, :text
  end
end
