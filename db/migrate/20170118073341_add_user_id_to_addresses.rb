class AddUserIdToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :user
  end
end
