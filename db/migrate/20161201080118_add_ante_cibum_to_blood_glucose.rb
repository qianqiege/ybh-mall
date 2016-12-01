class AddAnteCibumToBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_glucoses, :ante_cibum, :float
    add_column :blood_glucoses, :after_a_meal, :float
  end
end
