ActiveAdmin.register Light do
  menu parent: I18n.t("active_admin.menu.wallet_manage")
  permit_params :city, :strat,:over,:desc,:image
  index do
    selectable_column
    id_column

    column "城市图片" do |slide|
      image_tag(slide.image, size: "72x45", :alt => "city image")
    end
    column :city
    column :strat
    column :over
    column :desc
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "light" do
      f.input :city
      f.input :image,as: :file
      f.input :strat, as: :datepicker
      f.input :over, as: :datepicker
      f.input :desc,:as => :ckeditor
    end
    f.actions
  end
end
