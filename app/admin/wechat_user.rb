ActiveAdmin.register WechatUser do
  menu parent: I18n.t("active_admin.menu.user_manage")

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    selectable_column
    id_column

    column "Headimgurl" do |user|
      image_tag(user.headimgurl || ImageUploader.new.default_url, size: "40x40", :alt => "wechat head image")
    end
    column :open_id
    column :nickname
    column :subscribe
    column :auth_hash

    actions
  end
end
