class AddSomeAttributesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :wechat_user
    add_reference :orders, :address
    add_column :orders, :status, :string, default: 'pending'
    add_column :orders, :quantity, :integer
    add_column :orders, :price, :decimal, precision: 10, scale: 2
  end
end
