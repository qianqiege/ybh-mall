class CreateValueableProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :valueable_products do |t|
			t.string :name
			t.integer :contents_category_id
			t.string :image
			t.decimal :price, precision: 10, scale: 2
			t.string :product_number
			t.integer :inventory
			t.string :spec
			t.text :desc, limit: 65535
			t.boolean :is_show
			t.timestamps
    end
  end
end
