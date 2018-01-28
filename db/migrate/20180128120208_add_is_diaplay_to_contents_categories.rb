class AddIsDiaplayToContentsCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :contents_categories, :is_display, :boolean
  end
end
