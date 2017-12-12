ActiveAdmin.register New do
    menu parent: I18n.t("active_admin.menu.official_website")
    permit_params :title, :simple_desc, :sort, :image, :desc

    form(:html => { :multipart => true }) do |f|
      f.inputs "新闻" do
        f.input :title
        f.input :simple_desc
        f.input :image, as: :file
        f.input :desc,:as => :ckeditor
        f.input :sort,as: :select, collection: {'行业动态' => 1 ,'企业新闻' => 2 }
      end
      f.actions
    end
end
