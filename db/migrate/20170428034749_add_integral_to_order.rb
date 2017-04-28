class AddIntegralToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :integral, :decimal
  end
end
