ActiveAdmin.register HightTicket do
  menu parent: I18n.t("active_admin.menu.wallet_manage")

  index do
    selectable_column
    id_column

    column :user_id
    column :number
    column :order_id
    column '状态' do |hight|
      case hight.state
      when "panding"
        "未生效"
      when "start"
        "已生效"
      when "use"
        "已使用"
      when "not"
        "已无效"
      when "app"
        "已兑换"
      end
    end
    column :created_at
    column :updated_at
    actions defaults: true
  end
end
