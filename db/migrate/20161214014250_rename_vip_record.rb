class RenameVipRecord < ActiveRecord::Migration[5.0]
  def change
    rename_table :vip_records,:member_records
  end
end
