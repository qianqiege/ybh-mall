class AddIsEndToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :is_end, :boolean, default: false
  end
end
