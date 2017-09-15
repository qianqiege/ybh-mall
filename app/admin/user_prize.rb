ActiveAdmin.register UserPrize do
  menu parent: I18n.t("active_admin.menu.mall")
  permit_params :user_id, :lottery_prize_id, :state

  index do
    selectable_column
    id_column

    column :user
    column :lottery_prize
    column '状态' do |state|
      if state.state == "pending"
        "可使用"
      elsif state.state == "not"
        "已过期"
      elsif state.state == "use"
        "已使用"
      end
    end
    column "创建时间",:created_at

    actions
  end
end
