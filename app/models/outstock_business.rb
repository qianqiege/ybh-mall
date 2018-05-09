class OutstockBusiness < OutinstockBusiness
  def sub_stock business

    # 找到单项 中的产品
    #  批次 中的批次

    # 库存中  找到这个批次
    business.spd_business_batches.each do |batch|
      spd_stock_batch = SpdStockBatch.joins(:spd_stock).where(spd_stocks: {warehouse_id: business.warehouse_id, product_id: batch.spd_business_item.product_id}, spd_stock_batches: { batch: batch.batch }).first
      spd_stock_batch.count = spd_stock_batch.count.to_i - batch.count.to_i
      spd_stock_batch.out_count = batch.count.to_i
      spd_stock_batch.save
    end
  end
  def check_sub_stock business

    # 找到单项 中的产品
    #  批次 中的批次

    # 库存中  找到这个批次
    business.spd_business_batches.each do |batch|
      spd_stock_batch = SpdStockBatch.joins(:spd_stock).where(spd_stocks: {warehouse_id: business.warehouse_id, product_id: batch.spd_business_item.product_id}, spd_stock_batches: { batch: batch.batch }).first
      spd_stock_batch.count = spd_stock_batch.count.to_i - batch.count.to_i
      spd_stock_batch.save
    end
  end
end
