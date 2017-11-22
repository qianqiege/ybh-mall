ActiveAdmin.register ApplyCode do
  menu parent: I18n.t("active_admin.menu.mall")

  member_action :auth, method: :put do
    if resource.update_available!
      redirect_to :back, notice: "审核已通过，二维码生效!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  member_action :not, method: :put do
    if resource.update_void!
      redirect_to :back, notice: "审核已通过，二维码生效!"
    else
      redirect_to :back, notice: "操作失败!"
    end
  end

  index do
    selectable_column
    id_column

    column :user_id
    column :desc
    column '状态' do |code|
      if code.state == "pending"
        "待审核"
      elsif code.state == "available"
        "生效中"
      else
        "已失效"
      end
    end
    column :created_at
    column '审核' do |code|
      span do
        link_to '通过', auth_admin_apply_code_path(code), method: :put, data: { confirm: 'Are you sure?' } if code.pending?
      end
      span do
        link_to '不通过', not_admin_apply_code_path(code), method: :put, data: { confirm: 'Are you sure?' } if code.pending?
      end
    end
  end
end
