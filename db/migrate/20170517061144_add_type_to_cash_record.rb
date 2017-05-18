class AddTypeToCashRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :cash_records, :type, :string
  end
end
