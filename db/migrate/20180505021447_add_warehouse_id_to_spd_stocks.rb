class AddWarehouseIdToSpdStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_stocks, :warehouse_id, :integer
  end
end
