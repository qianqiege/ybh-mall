ActiveAdmin.register BloodPressure do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :diastolic_pressure, :systolic_pressure,:user_id,:examine_record_id,:phone,:state

  index do
    selectable_column
    id_column

    column :user
    column :systolic_pressure
    column :diastolic_pressure
    column :phone
    column :state
    actions
  end
end
