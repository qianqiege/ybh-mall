ActiveAdmin.register Weight do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :value,:user_id,:examine_record_id,:phone,:state
end
