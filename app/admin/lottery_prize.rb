ActiveAdmin.register LotteryPrize do
  permit_params :name, :image, :is_show
  menu parent: I18n.t("active_admin.menu.mall")
end
