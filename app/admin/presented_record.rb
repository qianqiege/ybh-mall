ActiveAdmin.register PresentedRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
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
    column :balance
    column "权重",:wight
  end
end
