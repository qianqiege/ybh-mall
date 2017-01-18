ActiveAdmin.register User do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :telphone,
                :email,
                :password,
                :identity_card,
                :name
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

  index do
    selectable_column
    id_column

    column :telphone
    column :email
    column :identity_card
    column :name
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "档案" do
      f.input :telphone
      f.input :email
      f.input :password
      f.input :identity_card
      f.input :name
    end
    f.actions
  end
end
