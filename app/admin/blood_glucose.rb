ActiveAdmin.register BloodGlucose do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :value, :mens_type,:user_id,:examine_record_id,:phone,:state

  index do
    selectable_column
    id_column

    column :user
    column :mens_type
    column :value
    column :phone
    column :state
    column :created_at
    actions
  end
end
