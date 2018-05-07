class InstockBusiness < OutinstockBusiness
  # 加业务中台库存
  # todolist: 要按照实际入库数量入库，而不是出库或采购数量入库
  def add_stock business
    # business: "业务单"
    business.spd_business_batches.each do |batch|
      # 判断  库存中 是否存在  业务单所属仓库  业务单中的产品   batch: "业务单批次"
      spd_stocks = SpdStock.where(warehouse_id: business.warehouse_id, product_id: batch.spd_business_item.product_id)
      if spd_stocks.present?
        #如果 库存中 有 这个产品
        # 判断  库存批次  中是否有  业务单中产品的批次
        spd_stock_batch = SpdStockBatch.where(spd_stock_id: spd_stocks.first.id, batch: batch.batch).first
        if spd_stock_batch.present?
          spd_stock_batch.count = spd_stock_batch.count.to_i + batch.count.to_i
          spd_stock_batch.save
        else
          SpdStockBatch.create(spd_stock_id: spd_stocks.first.id, batch: batch.batch, count: batch.count)
        end
      else
        spd_stock = SpdStock.create(warehouse_id: business.warehouse_id, product_id: batch.spd_business_item.product_id)
        SpdStockBatch.create(spd_stock_id: spd_stock.id, batch: batch.batch, count: batch.count)
      end
    end
  end
  # 加平行店库存
  # todolist: 要按照实际入库数量入库，而不是出库或采购数量入库
  def add_parallel_shop_stock business
    business.spd_business_items.each do |items|
    stock = Stock.where(parallel_shop_id: business.parallel_shop_id, product_id: items.product_id).first
      if stock.present?
        stock.amount = stock.amount + items.count
        stock.save
      else
        Stock.create(parallel_shop_id: business.parallel_shop_id, product_id: items.product_id, amount: items.count)
      end
    end
  end
end
