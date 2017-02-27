class AddOnluNumberToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :only_number, :string
    remove_column :organizations, :phone, :string
  end
end
