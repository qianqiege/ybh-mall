class AddRecordIdToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :record_id, :integer
  end
end
