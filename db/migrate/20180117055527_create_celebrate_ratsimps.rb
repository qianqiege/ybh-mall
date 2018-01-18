class CreateCelebrateRatsimps < ActiveRecord::Migration[5.0]
  def change
    create_table :celebrate_ratsimps do |t|
      t.integer :user_id
      t.string :waiter
      t.integer :parallel_shop_id
      t.integer :shop_order_id
      t.float :amount

      t.timestamps
    end
  end
end
