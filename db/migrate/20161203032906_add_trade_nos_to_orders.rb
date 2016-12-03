class AddTradeNosToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :trade_nos, :string
  end
end
