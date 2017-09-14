ActiveAdmin.register LotteryPrize do
  permit_params :name, :image, :is_show
  menu parent: I18n.t("active_admin.menu.mall")

  form(:html => { :multipart => true }) do |f|
    f.inputs "LotteryPrize" do
      f.input :name
      f.input :image ,as: :file
      f.input :is_show
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column "商品图片" do |slide|
      image_tag(slide.image_url, size: "150x50", :alt => "LotteryPrize")
    end
    column :name
    column :is_show
    column "创建时间",:created_at

    actions
  end

end
