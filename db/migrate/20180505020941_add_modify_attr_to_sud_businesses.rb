class AddModifyAttrToSudBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_businesses, :warehouse_id, :integer
    add_column :spd_businesses, :supplier_id, :integer
  end
end
