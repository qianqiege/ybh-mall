ActiveAdmin.register VipType do
  menu parent: I18n.t("active_admin.menu.member_manage")

  permit_params :name, :image, :remark

  index do
    selectable_column
    id_column

    column "会员类别图片" do |vip_type|
      image_tag(vip_type.image_url, size: "54x54")
    end
    column :name
    column :image
    column :remark

    column :updated_at
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "会员类别" do
      f.input :name
      f.input :remark
      f.input :image, :as => :file
    end
    f.actions
  end
end
