ActiveAdmin.register SpdStockBatch do

  menu parent: I18n.t( "active_admin.menu.stock")
  permit_params :spd_stock_id, :batch, :count, :out_count, :product_datetime, :expire_datetime

  actions :index
  index do
    id_column
    column "所属仓库" do |stock|
      stock.spd_stock.warehouse.name
    end
    column "产品" do |stock|
      stock.spd_stock.product.display_name
    end
    column :batch
    column :count
    column :out_count
    column :product_datetime
    column :expire_datetime
  end
#form
  form do |spd_stock_batch|
    spd_stock_batch.inputs do
      spd_stock_batch.input :spd_stock_id
      spd_stock_batch.input :batch
      spd_stock_batch.input :count
      spd_stock_batch.input :out_count
      spd_stock_batch.input :product_datetime
      spd_stock_batch.input :expire_datetime
    end
    spd_stock_batch.actions
  end
#show
  show do
    attributes_table do
      row :spd_stock_id
      row :batch
      row :count
      row :out_count
      row :product_datetime
      row :expire_datetime
    end
  end
  filter :spd_stock_warehouse_name_cont, label: "仓库", as: :select, collection: proc { Warehouse.all.pluck(:name) }
  filter :spd_stock_product_name_cont, label: "产品", as: :select, collection: proc { Product.joins(:spd_stocks).where(spd_stocks: {warehouse_id: Warehouse.all.ids}).pluck(:name) }

  csv do
    column "所属仓库" do |stock|
      stock.spd_stock.warehouse.name
    end
    column "产品" do |stock|
      stock.spd_stock.product.display_name
    end
    column :batch
    column :count
    column :out_count
    column :product_datetime
    column :expire_datetime
  end
end
