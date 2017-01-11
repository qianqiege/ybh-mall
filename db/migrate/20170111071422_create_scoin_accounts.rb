class CreateScoinAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :scoin_accounts do |t|
      t.string :account
      t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end
