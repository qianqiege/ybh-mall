ActiveAdmin.register ExchangeRecord do
menu parent: I18n.t("active_admin.menu.coin_record_manage")
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
actions :index
permit_params :user_id, :number, :status, :account,:opening,:name,:desc

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
    elsif record.state == "not"
      state = "审核未通过"
    elsif record.state == "pending"
      state = "待审核"
    end
  end
  column "申请日期" do |record|
    date record.created_at
  end
  # actions defaults: true
  column '审核操作(客服)' do |record|
    if record.state == "pending"
      span do
        link_to '审核通过',dealing_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
      end
      span do
        link_to '不通过',change_desc_admin_exchange_record_path(record, desc: :yes), method: :get
      end
    else
      date record.state_time
    end
  end
  column '处理操作(财务)' do |record|
    if record.state == "dealing"
      span do
        link_to '已处理',pending_admin_exchange_record_path(record),method: :put, data: { confirm: 'Are you sure?' }
      end
      span do
        link_to '不通过',change_desc_admin_exchange_record_path(record, desc: :yes), method: :get
      end
    else
      date record.updated_at
    end
  end
end

  controller do

    def update
      ExchangeRecord.find(params["id"]).update(desc: params["exchange_record"]["desc"])

      if ExchangeRecord.find(params["id"]).state == "pending"
         redirect_to  not_admin_exchange_record_path(params["id"].to_i)
      else
        redirect_to not_dealing_admin_exchange_record_path(params["id"].to_i)
      end
    end

  end

  member_action :pending, method: :put do
    resource.deal
    redirect_to admin_exchange_records_path
  end

  member_action :dealing, method: :put do
    resource.pass
    redirect_to admin_exchange_records_path
  end

  member_action :not, method: :get do
    resource.not
    redirect_to admin_exchange_records_path
  end

  member_action :not_dealing, method: :get do
    resource.not_dealing
    redirect_to admin_exchange_records_path
  end

  member_action :change_desc, method: :get do
    render 'edit.html.arb', :layout => false
  end

  form(:html => { :multipart => true }) do |f|
      f.inputs "填写原因" do
        f.input :desc
      end
    f.actions
  end

end
