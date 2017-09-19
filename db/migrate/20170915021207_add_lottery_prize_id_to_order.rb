class AddLotteryPrizeIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :lottery_prize_id, :integer
  end
end
