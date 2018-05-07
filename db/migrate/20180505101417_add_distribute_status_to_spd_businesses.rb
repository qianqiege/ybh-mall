class AddDistributeStatusToSpdBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_businesses, :distribute_status, :string
  end
end
