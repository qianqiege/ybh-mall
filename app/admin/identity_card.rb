ActiveAdmin.register IdentityCard do
  menu parent: I18n.t("active_admin.menu.user_manage")

  index do
    selectable_column
    id_column

    column "图片" do |id|
      image_tag(id.image_url, size: "72x45", :alt => "image")
    end
    column :user_id

    column '操作' do |identity_card|
      span do
        link_to '下载图片', identity_card.image_url, download: identity_card.user_id
      end
    end

    actions defaults: true

  end

end
