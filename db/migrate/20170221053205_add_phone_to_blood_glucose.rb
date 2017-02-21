class AddPhoneToBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_glucoses, :phone, :string
    add_column :blood_glucoses, :state, :string
  end
end
