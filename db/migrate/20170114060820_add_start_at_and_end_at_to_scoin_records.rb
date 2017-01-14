class AddStartAtAndEndAtToScoinRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_records, :start_at, :datetime
    add_column :scoin_records, :end_at, :datetime
  end
end
