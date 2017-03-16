ActiveAdmin.register WechatUser do
  menu parent: I18n.t("active_admin.menu.user_manage")
  permit_params :user_id
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
