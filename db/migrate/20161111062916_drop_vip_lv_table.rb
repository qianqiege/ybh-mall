class DropVipLvTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :vip_lvs
  end
end
