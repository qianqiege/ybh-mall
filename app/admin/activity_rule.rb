ActiveAdmin.register ActivityRule do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :rule,:activity_id,:max,:min,:y_coin,:scoin_type
  index do
    selectable_column
    id_column

    column :activity_id
    column :rule
    column :max
    column :min
    column :y_coin
    column :scoin_type
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
