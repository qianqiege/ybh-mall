class AddOrderIdToScoinAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_accounts, :order_id, :integer
  end
end
