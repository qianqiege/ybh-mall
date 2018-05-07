class AddTimeToSpdStockBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :spd_stock_batches, :product_datetime, :datetime
    add_column :spd_stock_batches, :expire_datetime, :datetime
  end
end
