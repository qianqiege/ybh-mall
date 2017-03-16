ActiveAdmin.register CoinChannel do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :name
end
