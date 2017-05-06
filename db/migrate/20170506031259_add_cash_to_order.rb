class AddCashToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :cash, :decimal
  end
end
