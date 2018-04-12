ActiveAdmin.register SupplierOrder do

  permit_params :order_number, :supplier_id, :warehouse_id, :admin_user_id, :discount, :preferential, :amounts_payable, :is_amended, :order_date, :purchase_status, :pay_status, :_destroy,
                supplier_order_items_attributes: [:id, :supplier_order_id, :product_id, :order_count, :prices, :amount, :discount, :receive_count, :_destroy]

  scope :all, :default => true
  scope :applying
  scope :approved
  scope :rejected

  index do
    selectable_column
    id_column
    column :order_number
    column :supplier_id
    column :warehouse_id
    column :admin_user_id
    column :discount
    column :preferential
    column :amounts_payable
    column :is_amended
    column :order_date
    column :purchase_status
    column :pay_status
    column :created_at

    if current_admin_user.role_name == "finance"
      column :review do |supplier_order|
        span do
          link_to '审核通过', review_admin_supplier_order_path(supplier_order), method: :put, data: {confirm: '确认审核通过'}
        end
        span do
          link_to '审核不通过', reject_admin_supplier_order_path(supplier_order), method: :put, data: {confirm: '确认审核不通过'}
        end
      end
    end
    if current_admin_user.role_name == "finance"
    else
      actions
    end
  end

  member_action :review, method: :put do
    if resource.may_review?
      resource.review
      resource.save
      redirect_to admin_supplier_orders_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  member_action :reject, method: :put do
    if resource.may_reject?
      resource.reject
      resource.save
      redirect_to admin_supplier_orders_path
    else
      redirect_to :back, notice: "只能审核不通过，等待审核的订单!"
    end
  end


  form(:html => {:multipart => true}) do |f|
    f.inputs "采购订单" do
      if params[:action] == "new"
        if !SupplierOrder.last.nil? && SupplierOrder.last.created_at.day == Time.now.day
          order_number = "CG" + "#{SupplierOrder.last.order_number[2, 12].to_i + 1}"
        else
          order_number = "CG" + Time.now.strftime("%Y%m%d") + "0001"
        end
      elsif params[:action] == "edit"
        order_number = SupplierOrder.find(params["id"]).order_number
      end

      # order_number = "#{Time.now.strftime("%Y%m%d").to_i}#{rand(1000..9999)}"
      f.input :order_number, :input_html => {:placeholder => "#{order_number}", :value => "#{order_number}", disabled: true}
      f.input :order_number, :input_html => {:value => "#{order_number}"}, as: :hidden
      f.input :supplier
      f.input :warehouse_id, as: :select, collection: current_admin_user.organization.warehouses.where(up_id: nil)
      f.input :admin_user_id, :input_html => {:placeholder => current_admin_user.email, :value => current_admin_user, disabled: true}
      f.input :admin_user_id, :input_html => {:value => current_admin_user.email}, as: :hidden
      f.input :discount
      f.input :preferential
      f.input :is_amended
      f.input :order_date, as: :date_time_picker
    end
    f.inputs do
      f.has_many :supplier_order_items, heading: '采购详单',
                 allow_destroy: true do |sup|
        sup.input :supplier_order_id
        sup.input :product
        sup.input :order_count
        sup.input :prices
        sup.input :receive_count
      end
    end
    actions
  end

  show do |supplier_order|
    attributes_table do
      row :order_number
      row :supplier_id
      row :warehouse_id
      row :admin_user_id
      row :discount
      row :preferential
      row :amounts_payable
      row :is_amended
      row :order_date
      row :purchase_status
      row :pay_status
      row :created_at
      panel "订单项详情" do
        table_for supplier_order.supplier_order_items do |items|
          items.column('id') {|supplier_order_items| supplier_order_items.id}
          items.column('产品') {|supplier_order_items| supplier_order_items.product.name}
          items.column('产品数量') {|supplier_order_items| supplier_order_items.order_count}
          items.column('产品单价') {|supplier_order_items| supplier_order_items.prices}
          items.column('收货数量') {|supplier_order_items| supplier_order_items.receive_count}
        end
      end
    end
  end
end
