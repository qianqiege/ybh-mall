class RemoveAttributesFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :people
    remove_column :orders, :order_time
    remove_column :orders, :order_type
    remove_column :orders, :user_id
    remove_column :orders, :number
  end
end
