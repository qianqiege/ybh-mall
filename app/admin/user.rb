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
                :staff_invitation_type,
                :is_admin,
                :is_test,
                :parallel_shop_id,
                :is_entrust,
                :yter_profile

  index do
    selectable_column
    id_column
    column :telphone
    column :id_number
    # column :identity_card
    column :name
    column :invitation_card
    column :invitation
    # column :organization
    column '身份',:type
    column '用户/员工',:status
    # column 'YBZ会员邀请数量',:ybz_number
    column '是否为合伙人', :is_partner
    column '是否为管理员', :is_admin
    column '注册时间',:created_at
    column :parallel_shop
    column :is_test
    column :is_entrust
    column :yter_profile do |user|
      user.yter_profile_name
    end
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
      f.input :is_admin
      f.input :is_test
      f.input :parallel_shop
      f.input :yter_profile, as: :select, collection: User::YTER_PROFILE.invert
      f.input :is_entrust
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
      row :is_admin
      row :created_at
      row :is_test
      row :parallel_shop
      row :is_entrust
      row :yter_profile
    end
  end

  csv do
    column :telphone
    column :name
    column :invitation_user_name
    column :staff_invitation_type
    column :created_at
  end

  filter :name, as: :select
  filter :maker_id,as: :select
  filter :id, as: :select
  filter :identity_card, as: :select
  filter :telphone, as: :select
  filter :invitation, as: :select
  filter :status, as: :select
  filter :created_at
  filter :staff_invitation_type, as: :select
  filter :is_test, as: :select
  filter :is_entrust, as: :select
  filter :yter_profile, as: :select

end
