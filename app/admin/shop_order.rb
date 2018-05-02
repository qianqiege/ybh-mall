ActiveAdmin.register ShopOrder do
  menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
  permit_params :number,
                :status,
                :total,
                :wechat_user_id,
                :user_id,
                :express_number,
                :difference,
                :parallel_shop_id,
                :shop_pay,
                :order_from,
                :ybyt_amount_receivable,
                shop_order_items_attributes: [:product_id,
                                              :id,
                                              :_destroy,
                                              :amount,
                                              :price,
                                              :sub_total
                ]
  form(:html => {:multipart => true}) do |f|
    f.inputs "平行店订单" do
      f.input :wechat_user
      f.input :user
      f.input :parallel_shop
      f.input :shop_pay
      f.input :express_number
      f.input :status, as: :select, collection: ['pending', 'finished']
      f.input :order_from, as: :select, collection: ['平行购买', '影子配领', '平行配领']
    end
    f.inputs do
      f.has_many :shop_order_items, allow_destroy: true do |a|
        a.input :product
        a.input :amount
      end
    end
    f.actions
  end
  batch_action '结算确认', if: proc{ can? :pay, ShopOrder} do |ids|
    batch_action_collection.find(ids).each do |shop_order|
      shop_order.status = "已结算"
      shop_order.save
    end
    redirect_to collection_path, alert: "已结算"
  end

  batch_action '收款确认', if: proc{ can? :receive, ShopOrder} do |ids|
    batch_action_collection.find(ids).each do |shop_order|
      shop_order.status = "已收款"
      shop_order.save
    end
    redirect_to collection_path, alert: "已收款"
  end

  index do
    selectable_column
    id_column
    column :number
    column :wechat_user
    column :user
    column :parallel_shop
    column :order_from
    column :express_number
    column :difference
    column :shop_pay
    column :status
    column :total
    column :ybyt_amount_receivable
    column :created_at
    column :updated_at
    actions
  end

  show do |shop_order|
    attributes_table do
      row :number
      row :wechat_user
      row :user
      row :parallel_shop
      row :express_number
      row :difference
      row :shop_pay
      row :status
      row :total
      row :created_at
      row :updated_at
      panel "订单详情" do
        table_for shop_order.shop_order_items do |t|
          t.column('id') {|shop_order_item| shop_order_item.id}
          t.column('产品') {|shop_order_item| shop_order_item.product.name}
          t.column('数量') {|shop_order_item| shop_order_item.amount}
          t.column('单价') {|shop_order_item| shop_order_item.product.now_product_price}
          t.column('小计') {|shop_order_item| shop_order_item.sub_total}
        end
      end
    end
  end


end