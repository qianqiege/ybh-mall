class AddNumberToScoinAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_accounts, :number, :decimal
  end
end
