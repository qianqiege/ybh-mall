ActiveAdmin.register HealthExamine do
menu parent: I18n.t("active_admin.menu.examine_manage")
permit_params :name, :url
end
