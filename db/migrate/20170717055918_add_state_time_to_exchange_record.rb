class AddStateTimeToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :state_time, :datetime
  end
end
