ActiveAdmin.register ReturnRequest do
  menu parent: I18n.t("active_admin.menu.mall")

  permit_params :status

  actions :index, :show

  index do
    selectable_column
    id_column

    column '所属用户' do |rr|
      link_to rr.order.wechat_user.name, admin_wechat_user_path(rr.order.wechat_user) if rr.order && rr.order.wechat_user
    end
    column :quantity
    column '商品库存' do |rr|
      rr.line_item.product.shop_count if rr.line_item && rr.line_item.product
    end
    column :tp do |rr|
      rr.human_tp
    end
    column :desc
    column "商品图片" do |rr|
      image_tag(rr.line_item.product.image_url, size: "72x45", :alt => "product image") if rr.line_item && rr.line_item.product
    end
    actions
  end

  show do |rr|
    attributes_table do
      row :id
      row '所属用户' do
        link_to rr.order.wechat_user.name, admin_wechat_user_path(rr.order.wechat_user) if rr.order && rr.order.wechat_user
      end
      row '手机号码' do
        rr.order.wechat_user.mobile if rr.order && rr.order.wechat_user
      end
      row :order
      row '提交数量' do
        rr.quantity
      end
      row '商品库存' do
        rr.line_item.product.shop_count if rr.line_item && rr.line_item.product
      end
      row :tp do
        rr.human_tp
      end
      row '商品图片' do
        image_tag(rr.line_item.product.image_url, size: "72x45", :alt => "product image") if rr.line_item && rr.line_item.product
      end
      row '购买数量' do
        rr.line_item.quantity
      end
      row '商品价格' do
        money rr.line_item.unit_price
      end
      row '收货地址' do
        rr.order.address.display_detail if rr.order && rr.order.address
      end
    end
  end
end
