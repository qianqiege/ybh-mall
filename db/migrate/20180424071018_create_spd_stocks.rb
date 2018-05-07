class CreateSpdStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :spd_stocks do |t|
      t.string   :name
      t.integer  :product_id
      t.string   :count
      t.string   :out_count

      t.timestamps
    end
  end
end
