class DropVipCardTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :vip_cards
  end
end
