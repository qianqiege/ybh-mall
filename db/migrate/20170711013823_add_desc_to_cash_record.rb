class AddDescToCashRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :cash_records, :desc, :string
  end
end
