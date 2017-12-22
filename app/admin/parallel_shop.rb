ActiveAdmin.register ParallelShop do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :title, :address, :main_business, :image, :desc
end
