class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_price
      t.string :shop_count
      t.string :boolean
      t.string :standard
      t.string :product_sort
      t.string :packaging
      t.string :production
      t.string :weight
      t.string :standard_number
      t.string :serial_number
      t.text :remark

      t.integer :order_item_id
      t.integer :shopping_id
      t.timestamps
    end
  end
end
