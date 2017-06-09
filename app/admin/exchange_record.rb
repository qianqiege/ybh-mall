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
  column :state do |record|
    if record.state == "dealed"
      state = "已处理"
    elsif record.state =="dealing"
      state = "待处理"
    else
      state = "待审核"
    end
  end
  column :created_at
  # actions defaults: true
  column '处理操作' do |record|
    if record.state == "pending"
      span do
        link_to '审核通过',update_review_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
      end
    end
    if record.state == "dealing"
      span do
        link_to '已处理',update_state_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
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

  member_action :update_state, method: :put do
    resource.deal
    redirect_to admin_exchange_records_path
  end

  member_action :update_review, method: :put do
    resource.pass
    redirect_to admin_exchange_records_path
  end

end
