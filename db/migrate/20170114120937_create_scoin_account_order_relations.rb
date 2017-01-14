class CreateScoinAccountOrderRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :scoin_account_order_relations do |t|
      t.integer :order_id
      t.integer :scoin_account_id

      t.timestamps
    end
  end
end
