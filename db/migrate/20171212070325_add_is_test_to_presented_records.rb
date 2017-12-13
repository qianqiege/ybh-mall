class AddIsTestToPresentedRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :is_test, :boolean,  default: false
  end
end
