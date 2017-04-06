class RenameScoinRecordsToCoinRecords < ActiveRecord::Migration[5.0]
  def change
    rename_table :scoin_records, :coin_records
  end
end
