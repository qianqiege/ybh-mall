class AddOrderFromToShopOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :shop_orders, :order_from, :string
  	add_column :shop_orders, :ybyt_amount_receivable, :float, default: 0.0 
  end
end
