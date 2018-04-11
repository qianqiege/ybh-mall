class CreateSupplierOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :supplier_orders do |t|
      t.string :order_number
      t.integer :supplier_id
      t.integer :warehouse_id
      t.integer :admin_user_id
      t.decimal :discount, precision: 2, scale: 2
      t.decimal :preferential, precision: 10, scale: 2
      t.decimal :amounts_payable, precision: 10, scale: 2
      t.boolean :is_amended
      t.datetime :order_date
      t.string :purchase_status
      t.string :pay_status

      t.timestamps
    end
  end
end
