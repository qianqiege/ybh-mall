ActiveAdmin.register ApplicationBusiness do

  menu parent: I18n.t( "active_admin.menu.spd")
  permit_params :up_id, :business_number, :out_warehouse, :warehouse_id, :type, :purchase_status, :allocate_status, :datetime, :preparer, :reviewer, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :pay_status
  index do
    selectable_column
    id_column
    column :up_id
    column :business_number
    column :out_warehouse
    column :warehouse_id
    column :type
    column :purchase_status
    column :allocate_status
    column :datetime
    column :preparer
    column :reviewer
    column :discount
    column :preferential
    column :amounts_payable
    column :is_amended
    column :order_date
    column :pay_status
    actions
  end
#form
  form do |spd_business|
    spd_business.inputs do
      spd_business.input :up_id
      spd_business.input :business_number
      spd_business.input :out_warehouse
      spd_business.input :warehouse_id
      spd_business.input :type
      spd_business.input :purchase_status
      spd_business.input :allocate_status
      spd_business.input :datetime
      spd_business.input :preparer
      spd_business.input :reviewer
      spd_business.input :discount
      spd_business.input :preferential
      spd_business.input :amounts_payable
      spd_business.input :is_amended
      spd_business.input :order_date
      spd_business.input :pay_status
    end
    spd_business.actions
  end
#show
  show do
    attributes_table do
      row :up_id
      row :business_number
      row :out_warehouse
      row :warehouse_id
      row :type
      row :purchase_status
      row :allocate_status
      row :datetime
      row :preparer
      row :reviewer
      row :discount
      row :preferential
      row :amounts_payable
      row :is_amended
      row :order_date
      row :pay_status
    end
  end


end
