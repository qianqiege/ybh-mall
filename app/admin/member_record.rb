ActiveAdmin.register MemberRecord do
  menu parent: I18n.t("active_admin.menu.record_manage")
  permit_params :member_number, :initiation_time,:user_id,:affiliation,:membership_card_id

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

  form(:html => { :multipart => true }) do |f|
    f.inputs "档案" do
      f.input :affiliation
      f.input :member_number
      f.input :initiation_time
      f.input :user
      f.input :membership_card
    end
    f.actions
  end
end
