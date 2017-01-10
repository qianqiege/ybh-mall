class AddIntegralToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :integral, :integer
    add_column :users, :s_coin, :float
    add_column :users, :y_coin, :float
  end
end
