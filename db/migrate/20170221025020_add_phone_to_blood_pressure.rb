class AddPhoneToBloodPressure < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_pressures, :phone, :string
    add_column :blood_pressures, :state, :string
  end
end
