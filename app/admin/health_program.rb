ActiveAdmin.register HealthProgram do
  menu parent: I18n.t("active_admin.menu.program_manage")
  permit_params :identity_card, :time, :coding, :product

  form(:html => { :multipart => true }) do |f|
    f.inputs "产品方案" do
      f.input :identity_card
      f.input :time, as: :datepicker
      f.input :coding
      f.input :product
    end
    f.actions
  end
end
