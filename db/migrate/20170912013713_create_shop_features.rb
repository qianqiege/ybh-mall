class CreateShopFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_features do |t|
      t.integer :feature_id
      t.integer :shop_id

      t.timestamps
    end
  end
end
