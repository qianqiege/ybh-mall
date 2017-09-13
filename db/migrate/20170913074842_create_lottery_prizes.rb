class CreateLotteryPrizes < ActiveRecord::Migration[5.0]
  def change
    create_table :lottery_prizes do |t|
      t.string :name
      t.string :image
      t.boolean :is_show

      t.timestamps
    end
  end
end
