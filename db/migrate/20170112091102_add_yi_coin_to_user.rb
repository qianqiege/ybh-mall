class AddYiCoinToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :y_coin, :decimal
  end
end
