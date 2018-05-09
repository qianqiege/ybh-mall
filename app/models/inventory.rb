class Inventory < SpdBusiness
  scope :approved, -> {where(inventory_status: "approved")}
  scope :rejected, -> {where(inventory_status: "rejected")}
  scope :applying, -> {where(inventory_status: "applying")}
  
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

  def sub_stock business
    # 找到单项 中的产品
    # 批次 中的批次
    # 库存中  找到这个批次
    business.spd_business_batches.each do |batch|
      spd_stock_batch = SpdStockBatch.joins(:spd_stock).where(spd_stocks: {warehouse_id: business.warehouse_id, product_id: batch.spd_business_item.product_id}, spd_stock_batches: { batch: batch.batch }).first
      spd_stock_batch.count = spd_stock_batch.count.to_i - batch.count.to_i
      spd_stock_batch.out_count = batch.count.to_i
      spd_stock_batch.save
    end
  end
end