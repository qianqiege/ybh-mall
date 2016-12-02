class RemoveValueFromHeartRate < ActiveRecord::Migration[5.0]
  def change
    remove_column :heart_rates, :value, :float
  end
end
