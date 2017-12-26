ActiveAdmin.register MoneyDetail do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :user_id, :reason, :shop_order_id, :record_id, :money
    form(:html => { :multipart => true }) do |f|
      f.inputs "月结" do
        f.input :user
        f.input :shop_order
        f.input :record_id
        f.input :reason
        f.input :money
      end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :user
        column :shop_order
        column :record_id
        column :reason
        column :money
        actions
    end
end
