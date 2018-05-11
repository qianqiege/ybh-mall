ActiveAdmin.register DistributionApplicationBusiness do

  menu parent: I18n.t("active_admin.menu.spd_distribution"), priority: 1
  permit_params :up_id, :business_number, :out_warehouse, :warehouse_id, :type, :purchase_status, :allocate_status, :datetime, :preparer, :reviewer, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :pay_status, :parallel_shop_id, :distribute_status,
                spd_business_items_attributes: [:id, :spd_business_id, :product_id, :count, :price, :amount, :discount, :_destroy]
  index do
    selectable_column
    id_column
    column :business_number
    column :warehouse
    column :parallel_shop
    column :distribute_status
    column :preparer
    column :reviewer
    actions
  end
#form
  form do |spd_business|
    spd_business.inputs do
      number = DistributionApplicationBusiness.generator_number params
      spd_business.input :business_number, :input_html => {:placeholder => "#{number}", :value => "#{number}", disabled: true}
      spd_business.input :business_number, :input_html => {:value => "#{number}"}, as: :hidden
      spd_business.input :warehouse_id, as: :select, collection: current_admin_user.try(:organization).try(:warehouses) || ['您没有所属仓库']
      spd_business.input :parallel_shop
      spd_business.input :preparer, :input_html => {:placeholder => current_admin_user.name, disabled: true}
      spd_business.input :preparer, :input_html => {:value => current_admin_user.name}, as: :hidden
      spd_business.input :is_amended
      spd_business.input :order_date, as: :date_time_picker
    end
    spd_business.inputs "单项" do
      spd_business.has_many :spd_business_items, heading: '备货',
                            allow_destroy: true do |spd_business_item|
        spd_business_item.input :product, as: :select, collection: Product.where(id: SpdStock.pluck(:product_id).uniq)
        spd_business_item.input :count
      end
    end
    spd_business.actions
  end
#show
  show do
    attributes_table do
      row :business_number
      row :warehouse_id
      row :parallel_shop
      row :type
      row :distribute_status
      row :preparer
      row :reviewer
      row :is_amended
      row :order_date

    end
    panel "订单项详情" do
      table_for distribution_application_business.spd_business_items do |items|
        items.column('id') {|spd_business_items| spd_business_items.id}
        items.column('产品') {|spd_business_items| "#{spd_business_items.product.name}--#{spd_business_items.product.only_number}"}
        items.column('产品数量') {|spd_business_items| spd_business_items.count}
        # items.column('添加批次') { link_to '添加批次', edit_admin_spd_business_item_path }
      end
    end
  end

  member_action :review, method: [:get, :post] do
    if resource.may_review?
      resource.review
      resource.reviewer = current_admin_user.name
      resource.save
      redirect_to admin_distribution_application_businesses_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  action_item :review_action, only: :show do
    link_to "审核通过", review_admin_distribution_application_business_path
  end

end
