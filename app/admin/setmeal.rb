# https://github.com/activeadmin/activeadmin/wiki/Ckeditor-integration
ActiveAdmin.register Setmeal do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :name, :image, :content, :type, :const

  index do
    selectable_column
    id_column

    column "套餐类别图片" do |setmeal|
      image_tag(setmeal.image_url, size: "28x28")
    end
    column "描述" do |setmeal|
      setmeal.content.first(10) + "..."
    end
    column :name
    column :image
    column :type

    column :updated_at
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "套餐类别" do
      f.input :name
      f.input :image, :as => :file
      f.input :content, :as => :ckeditor
      f.input :type
      f.input :const

    end
    f.actions
  end
end
