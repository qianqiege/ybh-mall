class AddUserIdToExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :exchange_records, :user_id, :integer
    add_column :exchange_records, :number, :decimal
    add_column :exchange_records, :type, :string
    add_column :exchange_records, :account, :string
  end
end
