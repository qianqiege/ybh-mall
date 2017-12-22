class CreateStockOuts < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_outs do |t|
      t.string :number
      t.integer :parallel_shop_id
      t.integer :purchase_order_id
      t.string :status, default:"pending"
      t.float :total
      t.string :contact
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
