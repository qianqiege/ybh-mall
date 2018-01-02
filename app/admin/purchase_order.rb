ActiveAdmin.register PurchaseOrder do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params   :number, :state, :total, :address, :contact, :phone, :parallel_shop_id,
                    purchase_order_items_attributes: [  :product_id,
                                                        :id,
                                                        :_destroy,
                                                        :amount,
                                                        ]
    actions :index, :show, :create, :new, :update
    form(:html => { :multipart => true }) do |f|
      f.inputs "采购订单" do
        f.input :parallel_shop,  as: :select, selected: current_admin_user.parallel_shop.try(:id)
        f.input :address
        f.input :contact
        f.input :phone
      end
      f.inputs do
          f.has_many :purchase_order_items, allow_destroy: true do |a|
            a.input :product
            a.input :amount
          end
        end
      f.actions
    end

    member_action :deal, method: :put do
      resource.deal
      redirect_to :back
    end

    index do
        selectable_column
        id_column
        column :number
        column :parallel_shop
        column :contact
        column :address
        column :phone
        column :state
        column :total
        column :created_at
        column :updated_at
        if current_admin_user.role_name == "db" || current_admin_user.role_name == "admin"
            column '订单操作' do |purchase_order|
              span do
                link_to '受理订单', deal_admin_purchase_order_path(purchase_order), method: :put, data: { confirm: 'Are you sure?' } if purchase_order.pending?
              end
            end
        end
        actions
    end

    show do |purchase_order|
        attributes_table do
            row :number
            row :parallel_shop
            row :contact
            row :address
            row :phone
            row :state
            row :total
            row :created_at
            row :updated_at
            panel "订单详情" do
                table_for purchase_order.purchase_order_items do |t|
                    t.column('id') { |purchase_order_item| purchase_order_item.id }
                    t.column('产品') { |purchase_order_item| purchase_order_item.product.name }
                    t.column('数量') { |purchase_order_item| purchase_order_item.amount }
                end
            end
        end
    end
end
