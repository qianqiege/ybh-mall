ActiveAdmin.register Rank do
  menu parent: I18n.t("active_admin.menu.serve_manage")
  permit_params :level

    form(:html => { :multipart => true }) do |f|
      f.inputs "等级" do
        f.input :level
      end
      f.actions
  end
end
