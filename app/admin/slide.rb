ActiveAdmin.register Slide do
menu parent: I18n.t("active_admin.menu.view_manage")
permit_params :desc, :image, :is_show, :weight, :url, :tp

index do
  selectable_column
  id_column

  column "轮播图" do |slide|
    image_tag(slide.image_url, size: "72x45", :alt => "slide image")
  end
  column :desc
  column :is_show
  column :weight
  column :url
  column :updated_at
  column "类型" do |slide|
    Slide::HUMAN_TYPE[slide.tp.to_i] if slide.tp
  end
  actions
end

form(:html => { :multipart => true }) do |f|
  f.inputs "Slide" do
    f.input :desc
    f.input :image, :as => :file
    f.input :is_show
    f.input :weight
    f.input :url
    f.input :tp, as: :select, collection: Slide::HUMAN_TYPE.invert, include_blank: false
  end
  f.actions
end


end
