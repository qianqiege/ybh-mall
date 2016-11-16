ActiveAdmin.register ReservationRecord do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :date, :name

    form(:html => { :multipart => true }) do |f|
      f.inputs "等级" do
        f.input :datetime
        f.input :name
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
