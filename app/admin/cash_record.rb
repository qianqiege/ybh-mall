ActiveAdmin.register CashRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
  index do
    selectable_column
    id_column

    column :user_id
    column :reason
    column :number
    column :is_effective
    column :created_at
  end
end
