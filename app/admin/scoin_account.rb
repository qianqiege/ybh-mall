ActiveAdmin.register ScoinAccount do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :account, :password,:state,:user_id,:number, :order_id,:state

  form do |f|
    f.inputs "S货币账户" do
      f.input :user
      f.input :account
      f.input :password
      f.input :state
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :user
    column :account
    column :password
    column :number
    column :state
    actions
  end
end
