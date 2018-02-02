class RemovePlanTypeFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :plan_type, :string
  end
end
