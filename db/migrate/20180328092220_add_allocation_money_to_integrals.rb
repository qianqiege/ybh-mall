class AddAllocationMoneyToIntegrals < ActiveRecord::Migration[5.0]
  def change
  	add_column :integrals, :allocation_money, :decimal
  end
end
