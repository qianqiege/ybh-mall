class CreateMoneyDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :money_details do |t|
      t.integer :user_id
      t.string :reason
      t.integer :shop_order_id
      t.integer :record_id
      t.float :money

      t.timestamps
    end
  end
end
