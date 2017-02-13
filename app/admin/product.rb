ActiveAdmin.register Product do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :name,
                :now_product_price,
                :original_product_price,
                :shop_count,
                :image,
                :desc,
                :is_show,
                :production,
                :packaging,
                :product_sort,
                :only_number

  index do
    selectable_column
    id_column

    column "商品图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "product image")
    end
    column :name
    column :only_number
    column :now_product_price
    column :original_product_price
    column :is_show
    column :shop_count
    column :desc
    column :production
    column :packaging
    column :product_sort
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Product" do
      f.input :name
      f.input :now_product_price
      f.input :original_product_price
      f.input :shop_count
      f.input :is_show
      f.input :production
      f.input :product_sort,:as => :ckeditor
      f.input :only_number
      f.input :packaging
      f.input :image, as: :file
      f.input :desc
    end
    f.actions
  end
end
