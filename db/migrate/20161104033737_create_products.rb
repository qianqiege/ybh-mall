class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :order_item_id
      t.string :name
      t.text :remark
      t.string :shop_count
      t.boolean :off_self


      t.timestamps
    end
  end
end
