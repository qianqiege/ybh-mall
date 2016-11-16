ActiveAdmin.register VipRecord do
  menu parent: "会员管理"
  permit_params :name,
                :sex,
                :address,
                :birthday,
                :identity_card,
                :telephone,
                :mobile,
                :emergency_contact,
                :vip_number,
                :initiation_time
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
