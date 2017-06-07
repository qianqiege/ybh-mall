ActiveAdmin.register ExchangeRecord do
menu parent: I18n.t("active_admin.menu.coin_record_manage")
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :number, :status, :account,:opening,:name

index do
  selectable_column
  id_column

  column :user
  column :number
  column :status
  column :account
  column :opening
  column :name
  column :review do |record|
    if record.review == "true"
      review = "已审核"
    else
      review = "待审核"
    end
  end
  column :state do |record|
    if record.state == "true"
      state = "已处理"
    else
      state = "待处理"
    end
  end
  column :created_at
  # actions defaults: true
  column '处理操作' do |record|
    if record.review == "false"
      span do
        link_to '审核通过',u_review_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
      end
    end
    if record.state == "false" && record.review == "true"
      span do
        link_to '已处理',u_state_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
      end
    end
  end
end

form(:html => { :multipart => true }) do |f|
  f.inputs "档案" do
    f.input :user
    f.input :number
    f.input :status
    f.input :account
    f.input :opening
    f.input :name
  end
  f.actions
end

  member_action :u_state, method: :put do
    resource.u_state
    redirect_to admin_exchange_records_path
  end

  member_action :u_review, method: :put do
    resource.u_review
    redirect_to admin_exchange_records_path
  end

end
