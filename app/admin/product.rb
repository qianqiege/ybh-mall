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
                :only_number,
                :priority,
                :is_custom_price,
                :is_consumption,
                :spec,
                :display,
                :height,
                :activity_id,
                :is_test,
                :led_away_category,
                :contents_category_id

  index do
    selectable_column
    id_column

    column "商品图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "product image")
    end
    column :qcode do |product|
      raw RQRCode::QRCode.new(mall_product_url(id: product.id, parallel_product_show: true), :size => 8, :level => :h).as_html
    end
    column :name
    column :only_number
    column :now_product_price
    column :original_product_price
    column :spec
    column'是否展示', :display
    column'是否上架', :is_show
    column :shop_count
    column :priority
    column '产品描述' do |product|
      truncate(raw product.desc)
    end
    column :production
    # column :product_sort
    column :activity_id
    column :is_test
    column :contents_category
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Product" do
      f.input :name
      f.input :now_product_price
      f.input :original_product_price
      f.input :shop_count
      f.input :display
      f.input :is_show
      f.input :spec
      f.input :is_custom_price
      f.input :is_consumption
      f.input :production
      f.input :product_sort
      f.input :only_number
      f.input :packaging
      f.input :image, as: :file
      f.input :priority
      f.input :height
      f.input :desc,:as => :ckeditor
      f.input :sort,as: :select, collection: {'销售产品' => '1' ,'活动产品' => '2' ,'虚拟产品' => '3','点亮心灯' => '4' }
      f.input :led_away_category, as: :select, collection: {'A' => '1', 'B' => '2', 'C' => '3'}
      f.input :activity
      f.input :is_test
      f.input :contents_category
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :name
      row :only_number
      row :now_product_price
      row :original_product_price
      row :is_show
      row :is_custom_price
      row :shop_count
      row :is_consumption
      row :production
      row :product_sort
      row :priority
      row '产品描述' do |product|
        truncate(raw product.desc)
      end
      row :is_test
      row :sort
      row :led_away_category
      row :contents_category
    end
  end

  filter :name, as: :select
  filter :only_number, as: :select
  filter :now_product_price, as: :select
  filter :original_product_price, as: :select
  filter :is_show, as: :select
  filter :shop_count, as: :select
  filter :production, as: :select
  filter :product_sort, as: :select
  filter :is_test, as: :select
end
