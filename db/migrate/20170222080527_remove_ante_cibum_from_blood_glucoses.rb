class RemoveAnteCibumFromBloodGlucoses < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_glucoses, :ante_cibum, :float
    remove_column :blood_glucoses, :after_a_meal, :float
  end
end
