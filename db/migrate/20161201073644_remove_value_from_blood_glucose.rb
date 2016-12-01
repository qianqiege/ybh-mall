class RemoveValueFromBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_glucoses, :value, :float
  end
end
