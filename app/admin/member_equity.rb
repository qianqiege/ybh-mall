ActiveAdmin.register MemberEquity do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :price,
                :number_of_time,
                :number,
                :serve_id,
                :product_id,
                :membership_card_id,
                :remark
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