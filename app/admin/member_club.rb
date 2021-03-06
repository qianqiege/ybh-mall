ActiveAdmin.register MemberClub do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :name, :image,:vip_type_id

  index do
    selectable_column
    id_column

    column "会员俱乐部图片" do |club|
      image_tag(club.image_url, size: "50x50")
    end
    column :name
    column :vip_type
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "会员卡俱乐部" do
      f.input :name
      f.input :image, :as => :file
      f.input :vip_type
    end
    f.actions
  end
end
