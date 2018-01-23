class AddContentsCategoryIdToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :contents_category_id, :integer
  end
end
