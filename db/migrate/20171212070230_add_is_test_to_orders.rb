class AddIsTestToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_test, :boolean,  default: false
  end
end
