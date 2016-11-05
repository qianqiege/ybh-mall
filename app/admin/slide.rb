ActiveAdmin.register Slide do

permit_params :desc, :image, :is_show, :weight, :url

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
  actions
end

form(:html => { :multipart => true }) do |f|
  f.inputs "Slide" do
    f.input :desc
    f.input :image, :as => :file
    f.input :is_show
    f.input :weight
    f.input :url
  end
  f.actions
end


end
