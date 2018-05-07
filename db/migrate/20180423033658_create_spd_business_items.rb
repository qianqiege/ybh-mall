class CreateSpdBusinessItems < ActiveRecord::Migration[5.0]
  def change
    create_table :spd_business_items do |t|
      t.integer :spd_business_id
      t.integer :product_id
      t.decimal :price, precision: 16, scale: 2
      t.decimal :amount, precision: 16, scale: 2
      t.float :discount
      t.string :count

      t.timestamps
    end
  end
end
