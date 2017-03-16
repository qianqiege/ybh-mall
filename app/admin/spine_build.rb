ActiveAdmin.register SpineBuild do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :name,:workstation_id,:rank_id,:serve_id

  form(:html => { :multipart => true }) do |f|
    f.inputs "筑脊师" do
      f.input :name
      f.input :workstation
      f.input :rank
      f.input :serve
    end
    f.actions
end
end
