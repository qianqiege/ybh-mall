class RemovePaymentFromCashRecords < ActiveRecord::Migration[5.0]
  def change
    remove_column :cash_records, :payment, :string
  end
end
