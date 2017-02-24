class AddInitialPriceToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :initial_price, :decimal, precision: 10, scale: 2
    Order.reset_column_information
    Order.all.each do |order|
      order.initial_price = order.price
      order.save validate: false
    end
  end
end
