class RemoveTimeFromBloodPressure < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_pressures, :time, :datetime
  end
end
