class AddNotExchangeToIntegral < ActiveRecord::Migration[5.0]
  def change
    add_column :integrals, :not_exchange, :decimal
    add_column :integrals, :not_cash, :decimal
    add_column :integrals, :appreciation, :decimal
    add_column :integrals, :not_appreciation, :decimal
    add_column :integrals, :count, :decimal
  end
end
