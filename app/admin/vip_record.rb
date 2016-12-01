ActiveAdmin.register VipRecord do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :name, :sex, :address, :birthday, :identity_card , :telephone, :mobile, :emergency_contact, :member_number, :initiation_time,:user_id

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
    f.input :name
    f.input :sex
    f.input :address
    f.input :birthday
    f.input :identity_card 
    f.input :telephone
    f.input :mobile
    f.input :emergency_contact
    f.input :member_number
    f.input :initiation_time
    f.input :user
  end
  f.actions
end
end
