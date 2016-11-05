ActiveAdmin.register Slide do

permit_params :desc, :image, :is_show, :weight, :url

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
