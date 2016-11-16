ActiveAdmin.register Serve do
  menu parent: I18n.t("active_admin.menu.serve_manage")
  permit_params :serve_name

    form(:html => { :multipart => true }) do |f|
      f.inputs "服务" do
        f.input :serve_name
      end
      f.actions
  end
end
