class AddOpeningToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :opening, :string
  end
end
