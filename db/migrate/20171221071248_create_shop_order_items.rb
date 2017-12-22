class CreateShopOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_order_items do |t|
      t.integer :shop_order_id
      t.integer :product_id
      t.integer :amount, default:1
      t.float :price, default:0.00
      t.float :sub_total, default:0.00

      t.timestamps
    end
  end
end
