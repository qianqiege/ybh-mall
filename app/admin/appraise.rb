ActiveAdmin.register Appraise do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :user_id, :result, :category, :number,:doctor_name

  index do
    selectable_column
    id_column

    column :user_id
    column :result
    column :category
    column :number
    column :doctor_name
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "评价" do
      f.input :user
      f.input :result
      f.input :category
      f.input :number
      f.input :doctor_name
    end
    f.actions
  end
end
