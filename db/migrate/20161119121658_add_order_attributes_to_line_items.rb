class AddOrderAttributesToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :order
    add_column :line_items, :in_cart, :boolean, default: true
    add_column :line_items, :unit_price, :decimal, precision: 10, scale: 2
  end
end
