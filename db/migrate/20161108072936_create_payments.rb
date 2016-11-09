class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.float :price
      t.string :status
      t.string :way

      t.integer :order_id
      t.integer :order_item_id
      t.timestamps
    end
  end
end
