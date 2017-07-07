class AddDescToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :desc, :string
  end
end
