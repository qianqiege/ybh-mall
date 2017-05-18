class RemoveTypeFromExchangeRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :exchange_records, :type, :string
    add_column :exchange_records, :status, :string
  end
end
