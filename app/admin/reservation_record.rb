ActiveAdmin.register ReservationRecord do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :time, :name,:tel,:spine_build_id

    form(:html => { :multipart => true }) do |f|
      f.inputs "预约记录" do
        f.input :time
        f.input :name
        f.input :tel
        f.input :spine_build
      end
      f.actions
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
