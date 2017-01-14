ActiveAdmin.register ScoinAccount do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :account, :password,:state,:user_id,:number, :order_id

  index do
    selectable_column
    id_column

    column :user
    column :account
    column :password
    column :number
    column :order
    actions
  end
end
