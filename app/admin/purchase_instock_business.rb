ActiveAdmin.register PurchaseInstockBusiness do

  menu parent: I18n.t("active_admin.menu.spd_purchase")
  permit_params :up_id, :business_number, :out_warehouse, :warehouse_id, :type, :purchase_status, :allocate_status, :datetime, :preparer, :reviewer, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :pay_status,
                spd_business_items_attributes: [:id, :spd_business_id, :product_id, :count, :_destroy]
  actions :index, :show
  index do
    selectable_column
    id_column
    column :business_number
    column :warehouse
    column :purchase_status
    column :is_amended
    column :order_date
    column :preparer
    column :reviewer
    actions
  end
#form
  form do |spd_business|
    spd_business.inputs do
      panel "基础信息", id: 'base_info' do
        number = PurchaseApplicationBusiness.generator_number params
        spd_business.input :business_number, :input_html => {:placeholder => "#{number}", :value => "#{number}", disabled: true}
        spd_business.input :business_number, :input_html => {:value => "#{number}"}, as: :hidden
        spd_business.input :warehouse_id, as: :select, collection: current_admin_user.organization.warehouses.where(up_id: nil)
        spd_business.input :type
        spd_business.input :purchase_status
        spd_business.input :preparer, :input_html => {:placeholder => current_admin_user.name, disabled: true}
        spd_business.input :reviewer
        spd_business.input :discount
        spd_business.input :preferential
        spd_business.input :amounts_payable
        spd_business.input :is_amended
        spd_business.input :preparer, :input_html => {:value => current_admin_user.name}, as: :hidden
        spd_business.input :order_date, as: :date_time_picker
      end
    end
    #todolist: 采购入库没有加入生产日期、到期日期
    spd_business.inputs "单项" do
      spd_business.has_many :spd_business_batches, heading: '采购单项',
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
      row :warehouse_id
      row :purchase_status
      row :is_amended
      row :order_date
      row :preparer
      row :reviewer
      row :created_at
    end
    panel "订单项详情" do
      table_for purchase_instock_business.spd_business_items do |item|
        item.column('id') {|spd_business_items| spd_business_items.id}
        item.column('产品') {|spd_business_items| spd_business_items.product.name}
        item.column('产品数量') {|spd_business_items| spd_business_items.count}
        item.column('添加批次') {|spd_business_items| link_to '添加批次', edit_admin_spd_business_item_path(spd_business_items)}
      end
    end

    panel "批次详情" do
      SpdBusiness.find(params[:id]).spd_business_items.ids
      table_for SpdBusinessBatch.where(spd_business_item_id: SpdBusiness.find(params[:id]).spd_business_items.ids) do |item|
        item.column('id') {|spd_business_batch| spd_business_batch.id}
        item.column('产品名称') {|spd_business_batch| spd_business_batch.spd_business_item.product.name}
        item.column('批次') {|spd_business_batch| spd_business_batch.batch}
        item.column('数量') {|spd_business_batch| spd_business_batch.count}
        item.column('生产日期') {|spd_business_batch| spd_business_batch.product_datetime}
        item.column('到期日期') {|spd_business_batch| spd_business_batch.expire_datetime}
      end
    end
  end
  member_action :review, method: [:get, :post] do
    if resource.may_review?
      resource.reviewer = current_admin_user.name
      resource.review
      resource.save
      redirect_to admin_purchase_instock_businesses_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  action_item :super_action, only: :show do
    link_to "采购入库审核", review_admin_purchase_instock_business_path
  end


end