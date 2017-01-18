class AddUsedAddressIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :used_address_id, :integer
  end
end
