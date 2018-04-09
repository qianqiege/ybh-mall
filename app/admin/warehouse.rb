ActiveAdmin.register Warehouse do
  menu parent: I18n.t("active_admin.menu.company_manage")

  permit_params :name, :organization_id, :up_id, :address

  form do |f|
    f.inputs "Warehouse" do
      f.input :name
      f.input :organization_id
      f.input :up_id
      f.input :address
    end
    f.actions
  end


end
