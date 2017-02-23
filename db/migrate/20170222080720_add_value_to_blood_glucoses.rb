class AddValueToBloodGlucoses < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_glucoses, :value, :float
    add_column :blood_glucoses, :mens_type, :integer
  end
end
