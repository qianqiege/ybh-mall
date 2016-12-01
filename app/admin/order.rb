ActiveAdmin.register Order do
  menu parent: I18n.t("active_admin.menu.mall")

  permit_params :status

  actions :index, :edit, :update, :show

  controller do
    def update
      if params[:order] && params[:order][:status] == 'cancel' && resource.may_make_cancel?
        resource.make_cancel
        resource.status = 'cancel'
        resource.save
        redirect_to resource_path, notice: 'Cancel!'
      else
        super
      end
    end
  end

  index do
    selectable_column
    id_column

    column :wechat_user
    column :price
    column :quantity
    column :status do |order|
      Order::STATUS_TEXT[order.status.to_sym]
    end
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.input :status, as: :select, collection: Order::STATUS_TEXT.invert, include: false
    f.actions
  end

  show do |order|
    attributes_table do
      row :id
      row :wechat_user
      row :price
      row :status do |order|
        Order::STATUS_TEXT[order.status.to_sym]
      end
      row :quantity
      row :address
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
end
