ActiveAdmin.register ExamineRecord do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :name, :idcard,:user_id
end
