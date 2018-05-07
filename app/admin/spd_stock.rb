ActiveAdmin.register SpdStock do

  menu parent: I18n.t( "active_admin.menu.stock")
  permit_params :name, :product_id, :count, :out_count
  actions :index, :show
  index do
    selectable_column
    id_column
    column :warehouse_id
    column :product_id
    column :count do |spd_stock|
      spd_stock.spd_stock_batches.sum(:count)
    end
    column :out_count do |spd_stock|
      spd_stock.spd_stock_batches.sum(:out_count)
    end
  end
#form
  form do |spd_stock|
    spd_stock.inputs do
      spd_stock.input :name
      spd_stock.input :product_id
      spd_stock.input :count
      spd_stock.input :out_count
    end
    spd_stock.actions
  end
#show
  show do
    attributes_table do
      row :name
      row :product_id
      row :count
      row :out_count
    end
  end

  filter :warehouse
  filter :product_name_cont, as: :select, collection: proc { Product.joins(:spd_stocks).where(spd_stocks: {warehouse_id: Warehouse.all.ids}).pluck(:name) }

end
