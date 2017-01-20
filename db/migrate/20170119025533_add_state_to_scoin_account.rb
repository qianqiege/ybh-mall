class AddStateToScoinAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_accounts, :state, :string
  end
end
