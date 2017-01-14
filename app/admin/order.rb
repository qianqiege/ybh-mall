ActiveAdmin.register Order do
  menu parent: I18n.t("active_admin.menu.mall")

  permit_params :status, :express_number, :activity_id, :user_id

  actions :index, :show


  controller do
    def update
      if params[:order] && params[:order][:status] == 'cancel' && resource.may_make_cancel?
        resource.make_cancel!
        redirect_to resource_path, notice: '已取消订单!'
      elsif params[:order] && params[:order][:express_number].present? && resource.may_send_product?
        resource.express_number = params[:order][:express_number]
        resource.save!
        resource.send_product!
        redirect_to resource_path, notice: '已设为发货状态!'
      else
        super
      end
    end
  end

  member_action :make_cancel, method: :put do
    if resource.may_make_cancel?
      resource.make_cancel!
      redirect_to :back, notice: "已取消订单!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :receive, method: :put do
    if resource.may_receive?
      resource.receive!
      redirect_to :back, notice: "已设为发货状态!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :express_number, method: :get do
    render 'edit.html.arb', :layout => false
  end

  index do
    selectable_column
    id_column

    column :wechat_user
    column :user_id
    column :activity
    column :price
    column :quantity
    column :number
    column :status do |order|
      order.human_state
    end
    actions defaults: true, :only => [] do |order|
      span do
        link_to '取消订单', make_cancel_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.pending?
      end
      span do
        link_to '填写货运单号', express_number_admin_order_path(order, express_number: :yes), method: :get if order.wait_send?
      end
      span do
        link_to '设为已收货', receive_admin_order_path(order), method: :put, data: { confirm: 'Are you sure?' } if order.wait_confirm?
      end
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.input :status, as: :select, collection: Order::STATUS_TEXT.invert, include: false
    f.actions
  end

  filter :status, as: :select, collection: Order::STATUS_TEXT.invert
  filter :wechat_user_mobile, as: :string

  show do |order|
    attributes_table do
      row :id
      row :wechat_user
      row :user_id
      row '手机号码' do
        order.wechat_user.mobile
      end
      row :price do
        money order.price
      end
      row :status do
        order.human_state
      end
      row :quantity
      row :activity
      row :address
      row :express_number
    end
    panel "订单项详情" do
      table_for order.line_items do |t|
        t.column('id') { |line_item| line_item.id }
        t.column('名称') { |line_item| line_item.product.name }
        t.column('图片') { |line_item| image_tag(line_item.product.image_url, size: "72x45", :alt => "product image") }
        t.column('数量') { |line_item| line_item.quantity }
        t.column('单价') { |line_item| line_item.unit_price }
      end
    end
  end

  # 目前只供填写货运单号使用，如果有其他用途需要做修改
  form(:html => { :multipart => true }) do |f|
    if params[:express_number].present?
      f.inputs "填写货运单号" do
        f.input :express_number
      end
    end
    f.actions
  end
end
