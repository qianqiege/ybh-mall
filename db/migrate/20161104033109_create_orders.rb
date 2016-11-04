class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.datetime :time
      t.string :people
      t.string :order_type


      t.timestamps
    end
  end
end
