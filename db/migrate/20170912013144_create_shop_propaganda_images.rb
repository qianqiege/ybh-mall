class CreateShopPropagandaImages < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_propaganda_images do |t|
      t.string :image
      t.integer :shop_id
      
      t.timestamps
    end
  end
end
