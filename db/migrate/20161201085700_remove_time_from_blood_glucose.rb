class RemoveTimeFromBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    remove_column :blood_glucoses, :time, :datetime
  end
end
