class AddAccountToCashRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :cash_records, :account, :string
  end
end
