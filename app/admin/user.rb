ActiveAdmin.register User do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :telphone,
                :email,
                :password,
                :identity_card,
                :name,
                :invitation_card,
                :invitation_user,
                :organization_id,
                :invitation_id,
                :y_coin

  index do
    selectable_column
    id_column

    column :telphone
    column :identity_card
    column :name
    column :invitation_card
    column :invitation_id
    column :organization
    column :y_coin
    column :type
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
      f.input :invitation_id
      f.input :organization
      f.input :type, as: :select, collection: ["Doctor", "Patient"]
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :id
      row :telphone
      row :email
      row :identity_card
      row :name
      row :invitation_card
      row :invitation_id
      row :organization
      row :y_coin
    end
  end

  filter :name, as: :select
  filter :identity_card, as: :select
  filter :telphone, as: :select
  filter :invitation_id, as: :string
end
