class AddNameToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :name, :string
  end
end
