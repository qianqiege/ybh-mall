ActiveAdmin.register InventoryLoss do
	menu parent: "盘点管理", priority: 2
	permit_params :up_id, :business_number, :type, :inventory_status, :preparer, :reviewer,
                spd_business_items_attributes: [:id, :spd_business_id, :product_id, :count, :price, :amount, :_destroy]

  scope :all, :default => true
  scope :applying
  scope :approved
  scope :rejected

  index do
    selectable_column
    id_column
    column :business_number
    column :warehouse
    column :type
    column :inventory_status
    column :is_amended
    column :order_date
    column :preparer
    column :reviewer
    actions
  end
#form
  form do |spd_business|
    spd_business.inputs do
      number = InventoryLoss.generator_number params
      spd_business.input :business_number, :input_html => {:placeholder => "#{number}", :value => "#{number}", disabled: true}
      spd_business.input :business_number, :input_html => {:value => "#{number}"}, as: :hidden
      spd_business.input :warehouse_id, as: :select, collection: current_admin_user.try(:organization).try(:warehouses) || ['您没有所属仓库'], :label=> "仓库"
      spd_business.input :preparer, :input_html => {:placeholder => current_admin_user.email, disabled: true}
      spd_business.input :preparer, :input_html => {:value => current_admin_user.email}, as: :hidden

    end
    spd_business.inputs "单项" do
      spd_business.has_many :spd_business_items, heading: '盘盈',
                            allow_destroy: true do |spd_business_item|
        spd_business_item.input :product, as: :select, collection: Product.where(id: SpdStock.pluck(:product_id).uniq), :label=> "产品"
        spd_business_item.input :count
      end
    end
    spd_business.actions
  end
#show
  show do
    attributes_table do
      row :business_number
      row :warehouse
      row :inventory_status
      row :preparer
      row :reviewer
    end
    panel "订单项详情" do
      table_for inventory_loss.spd_business_items do |item|
        item.column('id') {|spd_business_items| spd_business_items.id}
        item.column('产品') {|spd_business_items| spd_business_items.product.name} 
        item.column('产品数量') {|spd_business_items| spd_business_items.count}
        item.column('添加批次') {|spd_business_items| link_to '添加批次', edit_spd_spd_business_item_path(spd_business_items)}
      end
    end

    panel "批次详情" do
      SpdBusiness.find(params[:id]).spd_business_items.ids
      table_for SpdBusinessBatch.where(spd_business_item_id: SpdBusiness.find(params[:id]).spd_business_items.ids) do |item|
        item.column('id') {|spd_business_batch| spd_business_batch.id}
        item.column('产品名称') {|spd_business_batch| spd_business_batch.spd_business_item.product.name}
        item.column('批次') {|spd_business_batch| spd_business_batch.batch}
        item.column('数量') {|spd_business_batch| spd_business_batch.count}
      end
    end
  end

  member_action :review, method: [:get, :post] do
    if resource.may_review?
      resource.review
      resource.reviewer = current_admin_user.email
      resource.save
      redirect_to admin_inventory_loss_path
    else
      redirect_to :back, notice: "只能审核，等待审核的订单!"
    end
  end
  member_action :reject, method: [:get, :post] do
    if resource.may_reject?
      resource.reject
      resource.reviewer = current_admin_user.email
      resource.save
      redirect_to admin_inventory_loss_path
    else
      redirect_to :back, notice: "只能审核拒绝，等待审核的订单!"
    end
  end
  
  action_item :review_action, only: :show, if: proc{ current_admin_user.role_name == "admin" || current_admin_user.role_name == "parent_company_admin" } do
    link_to "审核通过", review_admin_inventory_loss_path
  end
  action_item :reject_action, only: :show, if: proc{ current_admin_user.role_name == "admin" || current_admin_user.role_name == "parent_company_admin" } do
    link_to "审核不通过", reject_admin_inventory_loss_path
  end

  filter :business_number
  filter :business_number
  filter :warehouse, as: :select
end