class AddTelToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :tel, :string
  end
end
