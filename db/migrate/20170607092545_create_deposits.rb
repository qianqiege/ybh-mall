class CreateDeposits < ActiveRecord::Migration[5.0]
  def change
    create_table :deposits do |t|
      t.string :trade_nos
      t.string :number
      t.string :payment
      t.decimal :price
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
