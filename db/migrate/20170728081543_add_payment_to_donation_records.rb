class AddPaymentToDonationRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :donation_records, :payment, :string
  end
end
