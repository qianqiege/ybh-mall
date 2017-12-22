ActiveAdmin.register ShopOrder do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params   :number,
                    :status,
                    :total,
                    :customer,
                    :user_id,
                    :express_number,
                    :difference,
                    :shop_pay,
                    shop_order_items_attributes: [  :product_id,
                                                    :id,
                                                    :_destroy,
                                                    :amount,
                                                    :price,
                                                    :sub_total
                                                    ]
    actions :show, :index, :update
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店订单" do
        f.input :number
        f.input :customer
        f.input :user
        f.input :express_number
        f.input :shop_pay
      end
      f.inputs do
          f.has_many :shop_order_items, allow_destroy: true do |a|
            a.input :product
            a.input :amount
          end
        end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :number
        column :customer
        column :user
        column :express_number
        column :difference
        column :shop_pay
        column :status
        column :total
        column :created_at
        column :updated_at
        actions
    end

    show do |shop_order|
        attributes_table do
            row :number
            row :customer
            row :user
            row :express_number
            row :difference
            row :shop_pay
            row :status
            row :total
            row :created_at
            row :updated_at
            panel "订单详情" do
                table_for shop_order.shop_order_items do |t|
                    t.column('id') { |shop_order_item| shop_order_item.id }
                    t.column('产品') { |shop_order_item| shop_order_item.product.name }
                    t.column('数量') { |shop_order_item| shop_order_item.amount }
                    t.column('单价') { |shop_order_item| shop_order_item.product.now_product_price }
                    t.column('小计') { |shop_order_item| shop_order_item.sub_total }
                end
            end
        end
    end
end
