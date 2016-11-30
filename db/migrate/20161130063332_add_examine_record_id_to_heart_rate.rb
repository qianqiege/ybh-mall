class AddExamineRecordIdToHeartRate < ActiveRecord::Migration[5.0]
  def change
    add_column :heart_rates, :examine_record_id, :integer
  end
end
