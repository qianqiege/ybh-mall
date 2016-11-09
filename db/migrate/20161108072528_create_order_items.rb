class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.string :product_number
      t.string :expressage_type
      t.string :way
      t.string :Logistics_type

      t.integer :order_id
      t.timestamps
    end
  end
end
