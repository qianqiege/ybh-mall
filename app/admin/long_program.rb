ActiveAdmin.register LongProgram do
  menu parent: I18n.t("active_admin.menu.program_manage")
  permit_params :doctor,
                :hospital,
                :recipe_number,
                :total,
                :detail,
                :blood_letting,
                :treatment,
                :identity_card,
                :level,
                :time
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
