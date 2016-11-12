class RemoveVipInfoIdFromVipRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :vip_records, :vip_info_id, :integer
  end
end
