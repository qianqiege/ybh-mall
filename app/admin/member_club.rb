ActiveAdmin.register MemberClub do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :name, :image

  index do
    selectable_column
    id_column

    column "会员俱乐部图片" do |club|
      image_tag(club.image_url, size: "80x50")
    end
    column :name
    column :image
    column :updated_at
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "会员卡俱乐部" do
      f.input :name
      f.input :image, :as => :file
    end
    f.actions
  end

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
end
