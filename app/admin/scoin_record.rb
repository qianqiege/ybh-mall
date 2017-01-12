ActiveAdmin.register ScoinRecord do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :number,:state,:scoin_account_id

  form(:html => { :multipart => true }) do |f|
    f.inputs "预约记录" do
      f.input :scoin_account
      f.input :state
      f.input :number
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :scoin_account
    column :state
    column :number
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
