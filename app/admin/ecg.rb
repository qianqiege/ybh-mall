ActiveAdmin.register Ecg do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :url, :user_id,:phone,:state

  index do
    selectable_column
    id_column

    column :user
    column :url
    column :phone
    column :state
    actions
  end
end
