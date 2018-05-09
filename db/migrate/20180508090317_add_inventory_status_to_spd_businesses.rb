class AddInventoryStatusToSpdBusinesses < ActiveRecord::Migration[5.0]
  def change
  	add_column :spd_businesses, :inventory_status, :string
  end
end
