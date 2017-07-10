ActiveAdmin.register ProductImage do
menu parent: I18n.t("active_admin.menu.mall")
permit_params :image,:url,:is_show,:product_id

  index do
    selectable_column
    id_column

    # column :wechat_user
    column "商品图片" do |image|
      image_tag(image.image_url, size: "50x50", :alt => "product image")
    end
    column :product
    column :image,as: :file
    actions defaults: true
  end


  form(:html => { :multipart => true }) do |f|
    f.inputs "ProductImage" do
      f.input :product
      f.input :image, as: :file
      f.input :is_show
    end
    f.actions
  end

end
