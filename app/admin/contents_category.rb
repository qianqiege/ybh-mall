ActiveAdmin.register ContentsCategory do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :name, :up_id, :is_display

  index do
    selectable_column
    id_column
    column :name
    column :up_id
    column :is_display
    actions
  end
end
