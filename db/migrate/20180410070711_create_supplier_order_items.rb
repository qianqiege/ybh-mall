class CreateSupplierOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :supplier_order_items do |t|
      t.integer :supplier_order_id
      t.integer :product_id
      t.integer :order_count
      t.decimal :prices, precision: 10, scale: 2
      t.decimal :amount, precision: 10, scale: 2
      t.decimal :discount, precision: 2, scale: 2
      t.integer :receive_count

      t.timestamps
    end
  end
end
