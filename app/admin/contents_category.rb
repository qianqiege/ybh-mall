ActiveAdmin.register ContentsCategory do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :name, :up_id

  index do
    selectable_column
    id_column
    column :name
    column :up_id
    actions
  end
end
