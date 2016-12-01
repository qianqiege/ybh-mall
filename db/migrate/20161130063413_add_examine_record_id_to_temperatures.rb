class AddExamineRecordIdToTemperatures < ActiveRecord::Migration[5.0]
  def change
    add_column :temperatures, :examine_record_id, :integer
  end
end
