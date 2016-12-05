class AddNumberToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number, :string
  end
end
