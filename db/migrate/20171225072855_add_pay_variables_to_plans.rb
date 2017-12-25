class AddPayVariablesToPlans < ActiveRecord::Migration[5.0]
  def change
  	add_column :plans, :trade_nos, :string
  	add_column :plans, :number, :string
  	add_column :plans, :payment, :string
  	add_column :plans, :status, :string
  	add_column :plans, :price, :decimal,:precision => 10,:scale=>2
  end
end