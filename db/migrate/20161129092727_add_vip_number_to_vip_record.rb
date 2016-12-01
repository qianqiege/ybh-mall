class AddVipNumberToVipRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :vip_records, :member_number, :string
    add_column :vip_records, :initiation_time, :datetime
  end
end
