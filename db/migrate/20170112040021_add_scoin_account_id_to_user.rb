class AddScoinAccountIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :scoin_account_id, :integer
  end
end
