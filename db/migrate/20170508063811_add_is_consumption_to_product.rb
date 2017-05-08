class AddIsConsumptionToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_consumption, :boolean
  end
end
