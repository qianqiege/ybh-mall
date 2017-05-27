class AddStateToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :state, :string
  end
end
