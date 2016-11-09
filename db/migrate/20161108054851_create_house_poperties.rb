class CreateHousePoperties < ActiveRecord::Migration[5.0]
  def change
    create_table :house_poperties do |t|
      t.string :house_name
      t.string :unit
      t.float :price
      t.float :total
      t.string :discount
      t.float :discount_price

      t.timestamps
    end
  end
end
