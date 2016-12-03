class AddRefundPriceAndRefundReasonToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :refund_reason, :string
    add_column :orders, :refund_price, :decimal, precision: 10, scale: 2
  end
end
