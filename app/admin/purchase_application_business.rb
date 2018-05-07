ActiveAdmin.register PurchaseApplicationBusiness do

  menu parent: I18n.t("active_admin.menu.spd_purchase")
  permit_params :up_id, :business_number, :out_warehouse, :warehouse_id, :type, :purchase_status, :allocate_status, :datetime, :preparer, :reviewer, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :pay_status, :supplier_id,
                spd_business_items_attributes: [:id, :spd_business_id, :product_id, :count, :price, :amount, :discount, :_destroy]

  index do
    selectable_column
    id_column
    column :business_number
    column :supplier
    column :warehouse_id
    column :type
    column :purchase_status
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
      number = PurchaseApplicationBusiness.generator_number params
      panel "基础信息", id: 'base_info' do
        spd_business.input :business_number, :input_html => {:placeholder => "#{number}", :value => "#{number}", disabled: true}
        spd_business.input :business_number, :input_html => {:value => "#{number}"}, as: :hidden
        spd_business.input :supplier
        spd_business.input :warehouse_id, as: :select, collection: current_admin_user.try(:organization).try(:warehouses).try{|x| x.where(up_id: nil)} || ['您没有所属仓库']
        spd_business.input :preparer, :input_html => {:placeholder => current_admin_user.email, disabled: true}
        spd_business.input :discount, :input_html => {:placeholder => "1", :value => "1"}
        spd_business.input :preferential
        spd_business.input :is_amended
        spd_business.input :preparer, :input_html => {:value => current_admin_user.email}, as: :hidden
        spd_business.input :order_date, as: :date_time_picker
      end
    end
    spd_business.inputs "单项" do
      spd_business.has_many :spd_business_items, heading: '采购单项',
                            allow_destroy: true do |spd_business_item|

        spd_business_item.input :product_id, as: :nested_select,
                level_1: { attribute: :supplier, fields: [:name], display_name: :name, minimum_input_length: 0},
                level_2: { attribute: :product_id,
                           fields: [:name], display_name: :name, minimum_input_length: 0,
                           url: "/admin/purchase_application_businesses/category",
                           response_root: 'paises' }
        spd_business_item.input :price
        spd_business_item.input :count
      end
    end

    spd_business.actions
  end
#show
  show do
    attributes_table do
      row :business_number
      row :supplier
      row :warehouse
      row :type
      row :purchase_status
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
    panel "订单项详情" do
      table_for purchase_application_business.spd_business_items do |items|
        items.column('id') {|spd_business_items| spd_business_items.id}
        items.column('产品') {|spd_business_items| spd_business_items.product.name}
        items.column('产品价格') {|spd_business_items| spd_business_items.price}
        items.column('产品数量') {|spd_business_items| spd_business_items.count}
        # items.column('添加批次') { link_to '添加批次', edit_admin_spd_business_item_path }
      end
    end
  end
  member_action :review, method: [:get, :post] do
    if resource.may_review?
      resource.review
      resource.reviewer = current_admin_user.email
      resource.save
      redirect_to admin_purchase_application_businesses_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  collection_action :category, method: [:get, :post] do
    render json: Product.where(supplier_id: params[:q][:supplier_eq]).each {|x| x.name = x.name + "---" + x.packaging}
  end
  action_item :super_action, only: :show do
    link_to "采购审核", review_admin_purchase_application_business_path
  end

end
