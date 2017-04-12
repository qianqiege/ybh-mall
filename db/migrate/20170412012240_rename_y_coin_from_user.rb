class RenameYCoinFromUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :y_coin, :locking_y
    add_column :users, :available_y ,:decimal,:precision => 10,:scale=>2
  end
end
