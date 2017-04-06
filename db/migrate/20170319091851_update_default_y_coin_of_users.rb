class UpdateDefaultYCoinOfUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :y_coin, :decimal, precision: 10, scale: 2, default: 0
  end
end
