class CreateUserPrizes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_prizes do |t|
      t.integer :user_id
      t.integer :lottery_prize_id
      t.string :state

      t.timestamps
    end
  end
end
