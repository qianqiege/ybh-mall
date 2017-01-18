ActiveAdmin.register Activity do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :name,:start_time,:stop_time

  form(:html => { :multipart => true }) do |f|
    f.inputs "S货币记录" do
      f.input :name
      f.input :start_time, as: :datepicker
      f.input :stop_time, as: :datepicker
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :start_time
    column :stop_time
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
