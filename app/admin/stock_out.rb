ActiveAdmin.register StockOut do
    permit_params   :number,
                    :status,
                    :total,
                    :parallel_shop_id,
                    :purchase_order_id,
                    :contact,
                    :phone,
                    :address,
                    stock_out_items_attributes: [  :product_id,
                                                    :id,
                                                    :_destroy,
                                                    :amount,
                                                    :price,
                                                    :sub_total
                                                    ]

    form(:html => { :multipart => true }) do |f|
      f.inputs "出库订单" do
        f.input :number
        f.input :purchase_order
      end
      f.inputs do
          f.has_many :stock_out_items, allow_destroy: true do |a|
            a.input :product
            a.input :amount
          end
        end
      f.actions
    end

    member_action :deal, method: :put do
      resource.deal
      redirect_to :back, notice: "已发货!"
    end

    member_action :sending, method: :put do
      resource.sending
      redirect_to :back, notice: "已收货!"
    end

    index do
        selectable_column
        id_column
        column :number
        column :parallel_shop
        column :purchase_order
        column :contact
        column :phone
        column :address
        column :status
        column :total
        column :created_at
        column :updated_at
        column '订单操作' do |stock_out|
          span do
            link_to '发货', deal_admin_stock_out_path(stock_out), method: :put, data: { confirm: 'Are you sure?' } if stock_out.pending?
          end
          span do
            link_to '收货', sending_admin_stock_out_path(stock_out), method: :put, data: { confirm: 'Are you sure?' } if stock_out.sending?
          end
        end
        actions
    end

    show do |stock_out|
        attributes_table do
            row :number
            row :parallel_shop
            row :purchase_order
            row :contact
            row :phone
            row :address
            row :status
            row :total
            row :created_at
            row :updated_at
            panel "出库单详情" do
                table_for stock_out.stock_out_items do |t|
                    t.column('id') { |stock_out_item| stock_out_item.id }
                    t.column('产品') { |stock_out_item| stock_out_item.product.name }
                    t.column('数量') { |stock_out_item| stock_out_item.amount }
                    t.column('单价') { |stock_out_item| stock_out_item.product.now_product_price }
                    t.column('小计') { |stock_out_item| stock_out_item.sub_total }
                end
            end
        end
    end
end
