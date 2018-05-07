ActiveAdmin.register SpdBusinessItem, namespace: :spd do

  menu parent: I18n.t("active_admin.menu.spd")
  permit_params :spd_business_id, :product_id, :count,
                spd_business_batches_attributes: [:id, :spd_business_item_id, :batch, :date, :count, :receive_count, :_destroy]

  index do
    selectable_column
    id_column
    column :spd_business_id
    column :product
    column :count
    actions
  end
#form
  form do |spd_business_item|
    spd_business_item.inputs "#{resource.spd_business.type}" do
      spd_business_item.input :spd_business_id
      spd_business_item.input :product
      spd_business_item.input :count
    end
    spd_business_item.inputs do
      spd_business_item.has_many :spd_business_batches, heading: '批次',
                                 allow_destroy: true do |spd_business_batch|
        spd_business_batch.input :batch
        spd_business_batch.input :count
      end
    end
    spd_business_item.actions
  end
#show
  show do |spd_business_item|
    attributes_table do
      row :spd_business_id
      row :product_id
      row :count
    end
    panel "订单项详情" do
      table_for spd_business_item.spd_business_batches do |batch|
        batch.column('id') {|spd_business_batches| spd_business_batches.id}
        batch.column('批次') {|spd_business_batches| spd_business_batches.batch}
        batch.column('数量') {|spd_business_batches| spd_business_batches.count}
        batch.column('生产日期') {|spd_business_batches| spd_business_batches.count}
        batch.column('有效期') {|spd_business_batches| spd_business_batches.count}
      end
    end
    panel "返回首页" do
      h1 link_to '返回业务首页', admin_root_path
    end
  end


end
