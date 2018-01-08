class AddPlanTypeToPlan < ActiveRecord::Migration[5.0]
  def change
      add_column :plans, :plan_type, :string
  end
end
