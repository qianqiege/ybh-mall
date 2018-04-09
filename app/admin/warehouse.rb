ActiveAdmin.register Warehouse do
  menu parent: I18n.t("active_admin.menu.company_manage")

  permit_params :name, :organization_id, :up_id, :address

  form do |f|
    f.inputs "Warehouse" do
      f.input :name
      f.input :up
      f.input :address
      f.input :organization, as: :select, selected: current_admin_user.organization.try(:id)
    end
    f.actions
  end



end
