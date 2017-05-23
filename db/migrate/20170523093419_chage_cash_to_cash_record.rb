class ChageCashToCashRecord < ActiveRecord::Migration[5.0]
  def change
    change_column :cash_records, :number, :decimal, precision: 10, scale: 2
  end
end
