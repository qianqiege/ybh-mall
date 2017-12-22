class CreateStockOutItems < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_out_items do |t|
      t.integer :stock_out_id
      t.integer :product_id
      t.integer :amount, default:1
      t.float :price, default:0.00
      t.float :sub_total, default:0.00

      t.timestamps
    end
  end
end
