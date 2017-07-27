class CreateDonationRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :donation_records do |t|
      t.integer :user_id
      t.decimal :price ,:precision => 10,:scale=>2
      t.decimal :integral ,:precision => 10,:scale=>2
      t.decimal :cash ,:precision => 10,:scale=>2
      t.decimal :count_price ,:precision => 10,:scale=>2
      t.string :order_number
      t.string :reason

      t.timestamps
    end
  end
end
