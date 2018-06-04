ActiveAdmin.register Product do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :name, :now_product_price, :original_product_price, :shop_count, :image, :desc, :is_show, :production, :packaging,
                :product_sort, :only_number, :priority, :is_custom_price, :is_consumption, :spec, :display, :height, :activity_id,
                :is_test, :led_away_coefficient_id, :contents_category_id, :general, :supplier_id, :is_pendding_sale, :value_batch,
                :yter_profile
  scope :all, :default => true
  scope :food
  index do
    selectable_column
    id_column
    # column "商品图片" do |slide|
    #   image_tag(slide.image_url, size: "72x45", :alt => "product image")
    # end
    # column :qcode do |product|
    #   raw RQRCode::QRCode.new(mall_product_url(id: product.id, parallel_product_show: true), :size => 8, :level => :h).as_html
    # end
    column :name
    column :only_number
    column :supplier
    column :now_product_price
    column :original_product_price
    column :spec
    column'是否展示', :display
    column'是否上架', :is_show
    column :shop_count
    column :priority
    # column '产品描述' do |product|
    #   truncate(raw product.desc)
    # end
    # column :production
    # column :product_sort
    column :activity_id
    column :is_test
    column :contents_category
    column :led_away_coefficient
    column :value_batch
    column :yter_profile do |product|
      product.yter_profile_name
    end
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Product" do
      panel "基础信息", id: 'base_info' do
        f.input :name
        f.input :supplier
        f.input :now_product_price
        f.input :original_product_price
        f.input :led_away_price
        f.input :shop_count
        f.input :spec
        # f.input :product_sort
        f.input :only_number
        f.input :packaging
        f.input :image, as: :file
        f.input :priority
        f.input :height
        f.input :general
        # f.input :sort,as: :select, collection: {'销售产品' => '1' ,'活动产品' => '2' ,'虚拟产品' => '3','点亮心灯' => '4' }
        f.input :led_away_coefficient
        # f.input :activity
        f.input :contents_category, as: :select, collection: ContentsCategory.where(up_id: ContentsCategory.where(up_id: nil).select(:id))
        f.input :yter_profile, as: :select, collection: User::YTER_PROFILE.invert
        f.input :display
        f.input :is_show
        f.input :is_custom_price
        f.input :is_consumption
        f.input :is_pendding_sale
        f.input :value_batch, as: :select, collection: Product::VALUE_BATCH
      end
      f.input :desc,:as => :ckeditor
      f.input :is_test
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :name
      row :only_number
      row :supplier
      row :now_product_price
      row :original_product_price
      row :is_show
      row :is_custom_price
      row :shop_count
      row :is_consumption
      row :production
      row :priority
      row '产品描述' do |product|
        truncate(raw product.desc)
      end
      row :is_test
      row :contents_category
      row :led_away_coefficient
      row :is_pendding_sale
      row :yter_profile
    end
  end

  filter :name, as: :select
  filter :only_number, as: :select
  filter :now_product_price, as: :select
  filter :original_product_price, as: :select
  filter :is_show, as: :select
  filter :shop_count, as: :select
  filter :production, as: :select
  filter :contents_category, as: :select
  filter :is_test, as: :select
  filter :led_away_coefficient, as: :select
end
