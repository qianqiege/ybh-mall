class CreateSpdStockBatches < ActiveRecord::Migration[5.0]
  def change
    create_table :spd_stock_batches do |t|
      t.integer :spd_stock_id
      t.string :batch
      t.string :count
      t.string :out_count

      t.timestamps
    end
  end
end
