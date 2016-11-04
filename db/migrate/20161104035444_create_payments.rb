class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :price
      t.string :status
      t.integer :order_id

      t.timestamps
    end
  end
end
