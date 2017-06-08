class ChangePriceFromDeposits < ActiveRecord::Migration[5.0]
  def change
  	change_column :presented_records, :balance, :decimal, precision: 10, scale: 2
  end
end
