ActiveAdmin.register Workstation do
  menu parent: I18n.t("active_admin.menu.serve_manage")
  permit_params :name,:city
  form(:html => { :multipart => true }) do |f|
    f.inputs "工作站" do
      f.input :name
      f.input :city
    end
    f.actions
end
end
