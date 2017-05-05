class AddCashToIntegral < ActiveRecord::Migration[5.0]
  def change
    add_column :integrals, :cash, :decimal
  end
end
