ActiveAdmin.register CelebrateRatsimp do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
  permit_params :user_id, :parallel_shop_id, :shop_order_id, :amount, :waiter

  form do |f|
    inputs "庆通分记录" do
      input :user
      input :parallel_shop
      input :shop_order
      input :amount
      input :waiter
    end
    actions
  end

  index do
    selectable_column
    id_column
    column :user
    column :parallel_shop
    column :shop_order
    column :amount
    column :waiter
    column :created_at
    column :updated_at
    actions
  end
end
