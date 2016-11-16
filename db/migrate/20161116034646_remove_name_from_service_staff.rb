class RemoveNameFromServiceStaff < ActiveRecord::Migration[5.0]
  def change
    remove_column :service_staffs, :name, :string
    remove_column :service_staffs, :grade, :string
    remove_column :service_staffs, :city, :string
    remove_column :service_staffs, :serve_number, :integer
    remove_column :service_staffs, :serve_id, :integer
  end
end
