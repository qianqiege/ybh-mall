ActiveAdmin.register AdminUser do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :email, :password, :password_confirmation, :role_name

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :role_name_label
    actions
  end

  filter :email, as: :select
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :role_name, as: :select, collection: AdminUser::ROLE_NAME_DATA.invert

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role_name, as: :select, collection: AdminUser::ROLE_NAME_DATA.invert, include: true
    end
    f.actions
  end

  show do |admin_user|
    attributes_table do
      row :id
      row :email
      row :password
      row :password_confirmation
      row :role_name
      row :created_at
      row :sign_in_count
    end
  end

end
