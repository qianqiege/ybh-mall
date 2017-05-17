class AddStatusToCashRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :cash_records, :status, :string
  end
end
