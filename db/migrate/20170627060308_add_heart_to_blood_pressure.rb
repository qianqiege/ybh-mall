class AddHeartToBloodPressure < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_pressures, :heart, :float
  end
end
