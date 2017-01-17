class AddPayTpToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :pay_tp, :integer, default: 0
  end
end
