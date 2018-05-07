ActiveAdmin.register SpdStockBatch do

  menu parent: I18n.t( "active_admin.menu.stock")
  permit_params :spd_stock_id, :batch, :count, :out_count

  actions :index
  index do
    id_column
    column "所属仓库" do |stock|
      stock.spd_stock.warehouse.name
    end
    column "product" do |stock|
      stock.spd_stock.product.name
    end
    column :batch
    column :count
    column :out_count
  end
#form
  form do |spd_stock_batch|
    spd_stock_batch.inputs do
      spd_stock_batch.input :spd_stock_id
      spd_stock_batch.input :batch
      spd_stock_batch.input :count
      spd_stock_batch.input :out_count
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
    end
  end
  filter :spd_stock_warehouse_name_cont, label: "仓库", as: :select, collection: proc { Warehouse.all.pluck(:name) }
  filter :spd_stock_product_name_cont, label: "产品", as: :select, collection: proc { Product.joins(:spd_stocks).where(spd_stocks: {warehouse_id: Warehouse.all.ids}).pluck(:name) }
end
