class CreatePurchaseOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_orders do |t|
      t.string :number
      t.integer :parallel_shop_id
      t.string :state, default:"pending"
      t.float :total
      t.string :address
      t.string :contact
      t.string :phone

      t.timestamps
    end
  end
end
