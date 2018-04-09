class AddOrganizationIdToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :organization_id, :integer
  end
end
