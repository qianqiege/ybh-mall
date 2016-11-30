class AddExamineRecordIdToWeight < ActiveRecord::Migration[5.0]
  def change
    add_column :weights, :examine_record_id, :integer
  end
end
