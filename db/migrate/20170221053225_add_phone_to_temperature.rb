class AddPhoneToTemperature < ActiveRecord::Migration[5.0]
  def change
    add_column :temperatures, :phone, :string
    add_column :temperatures, :state, :string
  end
end
