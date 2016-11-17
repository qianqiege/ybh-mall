ActiveAdmin.register SpineBuild do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :name,:workstation_id,:rank_id,:serve_id

  form(:html => { :multipart => true }) do |f|
    f.inputs "筑脊师" do
      f.input :name
      f.input :workstation
      f.input :rank
      f.input :serve
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
