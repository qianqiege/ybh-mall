class AddSaleTypeToSaleProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :sale_products, :sale_type, :string
  end
end
