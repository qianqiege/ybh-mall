class SpdStockBatch < ApplicationRecord
  belongs_to :spd_stock

  # todo
  def add_batch_stock(batch_count)
    self.count = self.count.to_f + batch_count.to_f
    self.save!
  end

  def spd_stock_warehouse
    Warehouse.all
  end

end
