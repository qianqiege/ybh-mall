class AddValueFromHeartRate < ActiveRecord::Migration[5.0]
  def change
    add_column :heart_rates, :value, :integer
  end
end
