class AddStatusAndTradeNosToDonationRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :donation_records, :status, :string
    add_column :donation_records, :trade_nos, :string
  end
end
