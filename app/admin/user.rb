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
                :status,
                :health_manager,
                :family_health_manager,
                :family_doctor,
                :staff_invitation_type

  index do
    selectable_column
    id_column

    column :telphone
    column :id_number
    column :identity_card
    column :name
    column :invitation_card
    column :invitation
    # column :organization
    column '身份',:type
    column '用户/员工',:status
    column 'YBZ会员邀请数量',:ybz_number
    column '注册时间',:created_at
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
      f.input :invitation
      f.input :organization
      f.input :type, as: :select, collection: ["Doctor", "Patient"]
      f.input :status, as: :select, collection: ["User", "Staff"]
      f.input :family_doctor
      f.input :family_health_manager
      f.input :health_manager
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
      row :status
      row :type
      row :created_at
    end
  end

  csv do
    column :telphone
    column :name
    column :invitation_user_name
    column :created_at
  end

  filter :name, as: :select
  filter :id, as: :select
  filter :identity_card, as: :select
  filter :telphone, as: :select
  filter :invitation, as: :select
  filter :status, as: :select
  filter :created_at
  filter :staff_invitation_type, as: :select

end
