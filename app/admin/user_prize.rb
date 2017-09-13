ActiveAdmin.register UserPrize do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :user_id, :lottery_prize_id, :state
end
