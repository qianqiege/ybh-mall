class AddRoleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:health_manager, :boolean
    add_column :users,:family_health_manager,  :boolean
    add_column :users,:family_doctor,  :boolean
  end
end
