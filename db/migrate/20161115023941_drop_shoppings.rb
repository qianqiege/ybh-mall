class DropShoppings < ActiveRecord::Migration[5.0]
  def change
    drop_table :shoppings
  end
end
