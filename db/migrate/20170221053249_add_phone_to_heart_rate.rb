class AddPhoneToHeartRate < ActiveRecord::Migration[5.0]
  def change
    add_column :heart_rates, :phone, :string
    add_column :heart_rates, :state, :string
  end
end
