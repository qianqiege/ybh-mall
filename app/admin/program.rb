ActiveAdmin.register Program do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :name,
                :image,
                :desc,
                :is_show,
                :features,
                :effect,
                :crowd

  index do
    selectable_column
    id_column

    column "方案图片" do |slide|
      image_tag(slide.image_url, size: "72x45", :alt => "image")
    end
    column "方案名称" do |program|
      truncate(raw program.name)
    end
    column "产品搭配功能" do |program|
      truncate(raw program.features)
    end
    column "单个产品功效" do |program|
      truncate(raw program.effect)
    end
    column "适宜人群" do |program|
      truncate(raw program.crowd)
    end
    column "备注" do |program|
      truncate(raw program.desc)
    end
    column "是否显示",:is_show
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "方案详情" do
      f.input :name
      f.input :features,:as => :ckeditor
      f.input :effect,:as => :ckeditor
      f.input :crowd,:as => :ckeditor
      f.input :desc,:as => :ckeditor
      f.input :image, as: :file
      f.input :is_show
    end
    f.actions
  end

end
