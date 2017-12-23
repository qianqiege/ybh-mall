ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc, :user_id
    form(:html => { :multipart => true }) do |f|
      f.inputs "平行店" do
        f.input :user
        f.input :title
        f.input :address
        f.input :main_business
        f.input :image
        f.input :desc
      end
      f.actions
    end
    index do
        selectable_column
        id_column
        column :user
        column :title
        column :address
        column :main_business
        column :image
        column :desc
        actions
    end
end
