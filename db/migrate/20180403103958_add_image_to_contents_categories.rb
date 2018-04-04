class AddImageToContentsCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :contents_categories, :image, :string
  end
end
