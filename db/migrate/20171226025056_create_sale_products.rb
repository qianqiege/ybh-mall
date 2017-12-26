class CreateSaleProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_products do |t|
      t.integer :product_id
      t.integer :amount
      t.integer :parallel_shop_id

      t.timestamps
    end
  end
end
