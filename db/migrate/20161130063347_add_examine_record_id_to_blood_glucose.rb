class AddExamineRecordIdToBloodGlucose < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_glucoses, :examine_record_id, :integer
  end
end
