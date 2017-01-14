ActiveAdmin.register ScoinType do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :name,:once,:everyday,:count, :limit_count

  form(:html => { :multipart => true }) do |f|
    f.inputs "S币包" do
      f.input :name
      f.input :once
      f.input :everyday
      f.input :limit_count
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :once
    column :everyday
    column :count
    column :limit_count
    actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
