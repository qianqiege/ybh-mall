class AddUpIdToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :up_id, :integer
  end
end
