class AddRoleNameToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :role_name, :string, default: 'member'
  end
end
