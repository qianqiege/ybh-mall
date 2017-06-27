class CreateIdataSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :idata_subscribes do |t|
	  t.string :trade_nos
      t.string :number
      t.string :payment
      t.decimal :price, precision: 10, scale: 2
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end

