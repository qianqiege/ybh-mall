ActiveAdmin.register SaleProduct do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :product_id, :amount, :parallel_shop_id
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店上架产品" do
        f.input :product, as: :select, collection: current_admin_user.parallel_shop.stock.map{|f| [Product.find(f.product_id).name, f.product_id]}
        f.input :parallel_shop,  as: :select, selected: current_admin_user.parallel_shop.try(:id)
        f.input :amount
      end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :product
        column :parallel_shop
        column :amount
        actions
    end
end
