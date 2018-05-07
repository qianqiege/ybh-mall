ActiveAdmin.register SpdBusinessBatch, namespace: :spd do

  menu parent: I18n.t( "active_admin.menu.spd")
  permit_params :spd_business_item_id, :batch, :date, :count, :receive_count
  index do
    selectable_column
    id_column
    column :spd_business_item_id
    column :batch
    column :date
    column :count
    column :receive_count
    actions
  end
#form
  form do |spd_business_batch|
    spd_business_batch.inputs do
      spd_business_batch.input :spd_business_item
      spd_business_batch.input :batch
      spd_business_batch.input :date, as: :date_time_picker
      spd_business_batch.input :count
      spd_business_batch.input :receive_count
    end
    spd_business_batch.actions
  end
#show
  show do
    attributes_table do
      row :spd_business_item_id
      row :batch
      row :date
      row :count
      row :receive_count
    end
  end


end
