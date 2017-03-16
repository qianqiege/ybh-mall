ActiveAdmin.register YcoinRule do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :name, :number, :coin_channel_id
end
