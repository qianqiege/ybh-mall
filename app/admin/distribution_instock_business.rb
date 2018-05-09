ActiveAdmin.register DistributionInstockBusiness do

  menu parent: I18n.t("active_admin.menu.spd_distribution"), priority: 3
  permit_params :up_id, :business_number, :out_warehouse, :parallel_shop_id, :type, :purchase_status, :allocate_status, :datetime, :preparer, :reviewer, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :pay_status,
                spd_business_items_attributes: [:id, :spd_business_id, :product_id, :count, :_destroy]
  index do
    selectable_column
    id_column
    column :business_number
    column :parallel_shop
    column :distribute_status
    column :is_amended
    column :order_date
    column :preparer
    column :reviewer
    actions
  end
#form
  form do |spd_business|
    spd_business.inputs do
      number = DistributionInstockBusiness.generator_number params
      panel "基础信息", id: 'base_info' do
        spd_business.input :business_number, :input_html => {:placeholder => "#{number}", :value => "#{number}", disabled: true}
        spd_business.input :business_number, :input_html => {:value => "#{number}"}, as: :hidden
        spd_business.input :preparer, :input_html => {:placeholder => current_admin_user.name, disabled: true}
        spd_business.input :reviewer
        spd_business.input :is_amended
        spd_business.input :preparer, :input_html => {:value => current_admin_user.name}, as: :hidden
        spd_business.input :order_date, as: :date_time_picker
      end
    end
    spd_business.inputs "单项" do
      spd_business.has_many :spd_business_items, heading: '调拨单项',
                            allow_destroy: true do |spd_business_item|
        spd_business_item.input :product
        spd_business_item.input :count
      end
    end

    spd_business.actions
  end
#show
  show do
    attributes_table do
      row :business_number
      row :parallel_shop
      row :type
      row :distribute_status
      row :preparer
      row :reviewer
      row :is_amended
      row :order_date
      row :pay_status
    end
    panel "订单项详情" do
      table_for distribution_instock_business.spd_business_items do |item|
        item.column('id') {|spd_business_items| spd_business_items.id}
        item.column('产品') {|spd_business_items| spd_business_items.product.name}
        item.column('产品数量') {|spd_business_items| spd_business_items.count}
      end
    end
  end
  member_action :review, method: [:get, :post] do
    if resource.may_review?
      resource.review
      resource.save
      redirect_to admin_distribution_instock_businesses_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  action_item :super_action, only: :show do
    link_to "备货入库审核", review_admin_distribution_instock_business_path
  end

end
