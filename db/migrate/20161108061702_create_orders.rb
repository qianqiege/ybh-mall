class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :people
      t.string :number
      t.datetime :order_time
      t.string :order_type

      t.integer :user_id
      t.timestamps
    end
  end
end
