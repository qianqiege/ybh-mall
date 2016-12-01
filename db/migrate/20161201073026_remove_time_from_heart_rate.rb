class RemoveTimeFromHeartRate < ActiveRecord::Migration[5.0]
  def change
    remove_column :heart_rates, :time, :datetime
  end
end
