class CreateShopActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_activities do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :shop_id
      
      t.timestamps
    end
  end
end
