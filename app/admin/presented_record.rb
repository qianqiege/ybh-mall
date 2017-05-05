ActiveAdmin.register PresentedRecord do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  actions :index, :show

  index do
    selectable_column
    id_column

    column :user_id
    column :number
    column :reason
    column :created_at
    # column :organization
    column :is_effective
    column :record_id
    column :type
  end
end
