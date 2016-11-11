ActiveAdmin.register Product do
  permit_params :name,
                :now_product_price,
                :original_product_price,
                :shop_count,
                :image,
                :desc,
                :is_show

  index do
    selectable_column
    id_column

    column "产品图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "product image")
    end
    column :name
    column :now_product_price
    column :original_product_price
    column :is_show
    column :shop_count
    column :desc
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Product" do
      f.input :name
      f.input :now_product_price
      f.input :original_product_price
      f.input :shop_count
      f.input :is_show
      f.input :image, as: :file
      f.input :desc
    end
    f.actions
  end
end
