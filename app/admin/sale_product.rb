ActiveAdmin.register SaleProduct do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :product_id, :amount, :parallel_shop_id
    form(:html => { :multipart => true }) do |f|
      f.inputs "产品上架" do
        if current_admin_user.role_name == "admin" || current_admin_user.role_name == "customer_service"
            f.input :product
            f.input :parallel_shop
        else
            f.input :product, as: :select, collection: current_admin_user.parallel_shop.stock.map{|f| [Product.find(f.product_id).display_name, f.product_id]}
            f.input :parallel_shop,  as: :select, selected: current_admin_user.parallel_shop.try(:id), :input_html => { :disabled => true }
            f.input :parallel_shop_id,  :input_html => { :value => current_admin_user.parallel_shop.id}, as: :hidden
        end
        # f.input :amount
        f.input :sale_type, as: :select, collection: SaleProduct::SALE_TYPE.invert
      end

      f.actions
    end

    index do
        selectable_column
        id_column
        column :product
        column :parallel_shop
        # column :amount
        column :sale_type do |sale_type|
          sale_type.sale_type_name
        end
        actions
    end
end
