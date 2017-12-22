class CreatePurchaseOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_order_items do |t|
      t.integer :purchase_order_id
      t.integer :product_id
      t.integer :amount, default:1

      t.timestamps
    end
  end
end
