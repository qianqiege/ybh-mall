class RemoveValueFromBloodPressure < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_pressures, :value, :float
  end
end
