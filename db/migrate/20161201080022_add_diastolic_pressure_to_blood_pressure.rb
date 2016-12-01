class AddDiastolicPressureToBloodPressure < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_pressures, :diastolic_pressure, :float
    add_column :blood_pressures, :systolic_pressure, :float
  end
end
