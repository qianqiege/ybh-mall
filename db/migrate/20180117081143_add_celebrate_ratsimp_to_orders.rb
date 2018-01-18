class AddCelebrateRatsimpToOrders < ActiveRecord::Migration[5.0]
  def change
      add_column :orders, :celebrate_ratsimp ,:decimal, precision: 10, scale: 2
  end
end
