class AddLotteryNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lottery_number, :integer
  end
end
