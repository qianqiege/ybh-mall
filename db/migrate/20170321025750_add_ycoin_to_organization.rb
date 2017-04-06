class AddYcoinToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :ycoin, :decimal
    add_column :organizations, :address, :string
    add_column :organizations, :phone, :string
  end
end
