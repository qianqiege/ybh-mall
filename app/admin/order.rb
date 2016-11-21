ActiveAdmin.register Order do
  menu parent: I18n.t("active_admin.menu.mall")
  actions :index, :edit, :update, :show
  index do
    selectable_column
    id_column

    column :wechat_user
    column :price
    column :quantity
    column :status
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.input :status
    f.actions
  end
end
