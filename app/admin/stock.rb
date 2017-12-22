ActiveAdmin.register Stock do
    permit_params :parallel_shop_id, :product_id, :amount

    index do
        selectable_column
        id_column
        column :parallel_shop
        column :product
        column :amount
        column :created_at
        column :updated_at
    end
end
