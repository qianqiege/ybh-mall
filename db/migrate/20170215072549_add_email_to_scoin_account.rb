class AddEmailToScoinAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_accounts, :email, :string
  end
end
