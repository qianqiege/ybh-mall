ActiveAdmin.register Warehouse do
  menu parent: I18n.t("active_admin.menu.company_manage")

  permit_params :name, :organization_id, :up_id, :address

  form do |f|
    f.inputs "Warehouse" do
      f.input :name
      f.input :up
      f.input :address
      if current_admin_user.role_name == "admin"
        f.input :organization
      elsif current_admin_user.role_name == "province_admin"
        f.input :organization,  as: :select, selected: current_admin_user.organization.try(:id), :input_html => { :disabled => true }
        f.input :organization_id, :input_html => { :value => current_admin_user.organization.id  }, as: :hidden
      end
    end
    f.actions
  end
end
