class CheageCashToOrder < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :cash, :decimal, precision: 10, scale: 2
    change_column :orders, :integral, :decimal, precision: 10, scale: 2
  end
end
