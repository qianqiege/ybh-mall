class AddCoinFromUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :coin, :decimal
  end
end
