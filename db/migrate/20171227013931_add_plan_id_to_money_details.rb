class AddPlanIdToMoneyDetails < ActiveRecord::Migration[5.0]
  def change
      add_column :money_details, :plan_id, :integer
  end
end
