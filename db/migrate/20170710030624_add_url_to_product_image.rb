class AddUrlToProductImage < ActiveRecord::Migration[5.0]
  def change
    add_column :product_images, :url, :string
    add_column :product_images, :is_show, :boolean
  end
end
