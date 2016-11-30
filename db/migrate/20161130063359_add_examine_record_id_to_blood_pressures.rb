class AddExamineRecordIdToBloodPressures < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_pressures, :examine_record_id, :integer
  end
end
