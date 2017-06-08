class AddPriceToDeposits < ActiveRecord::Migration[5.0]
  def change
    add_column :deposits, :price, :decimal, precision: 10, scale: 2
  end
end
