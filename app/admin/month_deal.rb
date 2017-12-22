ActiveAdmin.register MonthDeal do
    permit_params   :parallel_shop_id, :should_pay, :already_pay, :status,
                    month_deal_items_attributes: [  :product_id,
                                                    :id,
                                                    :_destroy,
                                                    :amount,
                                                    :price,
                                                    :sub_total
                                                    ]

    index do
        selectable_column
        id_column
        column :parallel_shop
        column :should_pay
        column :already_pay
        column :status
        actions
    end

    form(:html => { :multipart => true }) do |f|
      f.inputs "月结" do
        f.input :parallel_shop
        f.input :already_pay
      end
      f.inputs do
          f.has_many :month_deal_items, allow_destroy: true do |a|
            a.input :product
            a.input :amount
          end
        end
      f.actions
    end

    show do |month_deal|
        attributes_table do
            row :parallel_shop
            row :should_pay
            row :already_pay
            row :status
            row :created_at
            row :updated_at
            panel "详情" do
                table_for month_deal.month_deal_items do |t|
                    t.column('id') { |month_deal_item| month_deal_item.id }
                    t.column('产品') { |month_deal_item| month_deal_item.product.name }
                    t.column('数量') { |month_deal_item| month_deal_item.amount }
                    t.column('单价') { |month_deal_item| month_deal_item.price }
                    t.column('小计') { |month_deal_item| month_deal_item.sub_total }
                end
            end
        end
    end
end
