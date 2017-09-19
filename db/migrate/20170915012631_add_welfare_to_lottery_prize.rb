class AddWelfareToLotteryPrize < ActiveRecord::Migration[5.0]
  def change
    add_column :lottery_prizes, :welfare, :string
  end
end
