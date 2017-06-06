class AddPaymentToCashRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :cash_records, :payment, :string
  end
end
