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
  column :created_at
  actions defaults: true
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

end
