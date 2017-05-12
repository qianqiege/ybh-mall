class AddBalanceToPrsentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :balance, :decimal
  end
end
