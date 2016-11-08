class CreateStockRights < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_rights do |t|
      t.string :name
      t.string :count
      t.string :price

      t.timestamps
    end
  end
end
