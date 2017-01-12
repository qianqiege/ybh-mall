class RemoveSCoinFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :s_coin, :float
    remove_column :users, :y_coin, :float
  end
end
