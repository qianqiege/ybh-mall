class RemoveOrderIdFromScoinAccounts < ActiveRecord::Migration[5.0]
  def change
    remove_column :scoin_accounts, :order_id, :integer
  end
end
