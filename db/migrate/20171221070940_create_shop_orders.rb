class CreateShopOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_orders do |t|
      t.string :number
      t.string :customer
      t.integer :user_id
      t.float :total, default:0.00
      t.string :status, default:"pending"
      t.string :express_number
      t.float :difference
      t.float :shop_pay, default:0.00

      t.timestamps
    end
  end
end
