class AddAmountToScoinAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_accounts, :amount, :decimal,:precision => 10,:scale=>1
  end
end
