class ChageCashToIntegral < ActiveRecord::Migration[5.0]
  def change
    change_column :integrals, :locking, :decimal, precision: 10, scale: 2
    change_column :integrals, :available, :decimal, precision: 10, scale: 2
    change_column :integrals, :exchange, :decimal, precision: 10, scale: 2
    change_column :integrals, :cash, :decimal, precision: 10, scale: 2
    change_column :integrals, :not_exchange, :decimal, precision: 10, scale: 2
    change_column :integrals, :not_cash, :decimal, precision: 10, scale: 2
    change_column :integrals, :appreciation, :decimal, precision: 10, scale: 2
    change_column :integrals, :not_appreciation, :decimal, precision: 10, scale: 2
    change_column :integrals, :count, :decimal, precision: 10, scale: 2
  end
end
