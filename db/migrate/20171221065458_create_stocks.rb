class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :parallel_shop_id
      t.integer :product_id
      t.integer :amount, default:0

      t.timestamps
    end
  end
end
