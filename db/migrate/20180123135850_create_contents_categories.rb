class CreateContentsCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :contents_categories do |t|
      t.string :name
      t.integer :up_id

      t.timestamps
    end
  end
end
