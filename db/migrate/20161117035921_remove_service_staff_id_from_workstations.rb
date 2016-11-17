class RemoveServiceStaffIdFromWorkstations < ActiveRecord::Migration[5.0]
  def change
    remove_column :workstations, :service_staff_id, :integer
  end
end
