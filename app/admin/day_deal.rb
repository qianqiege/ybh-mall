ActiveAdmin.register DayDeal do
    permit_params   :parallel_shop_id, :status, :should_pay, :already_pay,
                    day_deal_items_attributes: [    :product_id,
                                                    :id,
                                                    :_destroy,
                                                    :amount,
                                                    :price,
                                                    :sub_total
                                                    ]

    form(:html => { :multipart => true }) do |f|
      f.inputs "日清" do
        f.input :parallel_shop
        f.input :already_pay
      end
      f.inputs do
          f.has_many :day_deal_items, allow_destroy: true do |a|
            a.input :product
            a.input :amount
          end
        end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :parallel_shop
        column :should_pay
        column :already_pay
        column :status
        column :created_at
        column :updated_at
        actions
    end

    show do |day_deal|
        attributes_table do
            row :parallel_shop
            row :should_pay
            row :already_pay
            row :status
            row :created_at
            row :updated_at
            panel "订单详情" do
                table_for day_deal.day_deal_items do |t|
                    t.column('id') { |day_deal_item| day_deal_item.id }
                    t.column('产品') { |day_deal_item| day_deal_item.product.name }
                    t.column('数量') { |day_deal_item| day_deal_item.amount }
                    t.column('单价') { |day_deal_item| day_deal_item.price }
                    t.column('小计') { |day_deal_item| day_deal_item.sub_total }
                end
            end
        end
    end
end
