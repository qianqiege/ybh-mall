class OutinstockBusiness < SpdBusiness
  # 收货  清除在途  数量
  def sub_out_count business
    business.spd_business_batches.each do |batch|
      spd_stock_batch = SpdStockBatch.joins(:spd_stock).where(spd_stocks: {warehouse_id: business.up.warehouse_id, product_id: batch.spd_business_item.product_id}, spd_stock_batches: { batch: batch.batch }).first
      spd_stock_batch.out_count = spd_stock_batch.out_count.to_i - batch.count.to_i
      spd_stock_batch.save
    end
  end
  # 平行店收货后 清除在途数量 ps： 平行店收货不需要批次
  # todolist 如果收货数量不等于出库数量会有bug
  def parallel_shop_sub_out_count business
    business.up.spd_business_batches.each do |batch|
      spd_stock_batch = SpdStockBatch.joins(:spd_stock).where(spd_stocks: {warehouse_id: business.up.warehouse_id, product_id: batch.spd_business_item.product_id}, spd_stock_batches: { batch: batch.batch }).first
      spd_stock_batch.out_count = spd_stock_batch.out_count.to_i - batch.count.to_i
      spd_stock_batch.save
    end
  end
end
