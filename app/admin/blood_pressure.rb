ActiveAdmin.register BloodPressure do
  menu parent: I18n.t("active_admin.menu.examine_manage")
  permit_params :diastolic_pressure, :systolic_pressure,:wechat_user_id,:examine_record_id
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
