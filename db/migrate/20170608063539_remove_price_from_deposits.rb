class RemovePriceFromDeposits < ActiveRecord::Migration[5.0]
  def change
    remove_column :deposits, :price, :decimal
  end
end
