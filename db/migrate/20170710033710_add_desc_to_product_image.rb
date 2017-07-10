class AddDescToProductImage < ActiveRecord::Migration[5.0]
  def change
    add_column :product_images, :desc, :string
  end
end
