ActiveAdmin.register UserPrize do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :user_id, :lottery_prize_id, :state

  index do
    selectable_column
    id_column

    column :user
    column :lottery_prize
    column :state
    column "创建时间",:created_at

    actions
  end
end
