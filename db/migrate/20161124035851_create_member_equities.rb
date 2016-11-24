class CreateMemberEquities < ActiveRecord::Migration[5.0]
  def change
    create_table :member_equities do |t|
      t.integer :number_of_time
      t.integer :number
      t.decimal :total_price
      t.integer :serve_id
      t.integer :product_id
      t.integer :membership_card_id

      t.timestamps
    end
  end
end
