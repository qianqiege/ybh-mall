ActiveAdmin.register MembershipCard do
  menu parent: I18n.t("active_admin.menu.member_manage")
  permit_params :name, :image, :desc,:member_club_id,:setmeal_id,:house_poperty_id,:stock_right_id,:discount,:allowance

  index do
    selectable_column
    id_column

    column "会员卡图片" do |card|
      image_tag(card.image_url, size: "80x50")
    end
    column :name
    column :image
    column :updated_at
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "会员卡" do
      f.input :name
      f.input :member_club
      f.input :serve
      f.input :house_poperty
      f.input :stock_right
      f.input :image, :as => :file
      f.input :desc
      f.input :allowance
      f.input :discount
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
