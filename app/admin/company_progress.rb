ActiveAdmin.register CompanyProgress do
    menu parent: I18n.t("active_admin.menu.official_website")
    permit_params :date, :image, :desc

    form(:html => { :multipart => true }) do |f|
      f.inputs "企业大事件" do
        f.input :date
        f.input :image, as: :file
        f.input :desc,:as => :ckeditor
      end
      f.actions
    end
end
