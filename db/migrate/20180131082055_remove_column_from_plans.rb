class RemoveColumnFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :is_capital, :boolean
    remove_column :plans, :capital_id, :integer
    remove_column :plans, :is_maker, :boolean
  end
end
