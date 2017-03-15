class AddCoinChannelIdToCoinRule < ActiveRecord::Migration[5.0]
  def change
    add_column :ycoin_rules, :coin_channel_id, :integer
  end
end
