ActiveAdmin.register User do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :telphone,
                :email,
                :password,
                :identity_card,
                :name,
                :invitation_card,
                :invitation_user,
                :organization_id
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
    column :invitation_card
    column :invitation_user
    column :organization
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "档案" do
      f.input :name
      f.input :telphone
      f.input :email
      f.input :password
      f.input :identity_card
      f.input :invitation_card
      f.input :invitation_user
      f.input :organization
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :telphone
    column :identity_card
    column :password
    actions
  end

end
