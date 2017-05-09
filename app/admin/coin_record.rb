ActiveAdmin.register CoinRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
  permit_params :level_type,:state, :account_id, :account_type, :coin_type_id, :start_at, :type,:end_at

  form(:html => { :multipart => true }) do |f|
    f.inputs "货币记录" do
      f.input :account, collection: (ScoinAccount.all + User.all)
      f.input :coin_type
      f.input :type
      f.input :start_at, as: :datepicker
      f.input :end_at, as: :datepicker
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :account
    column :coin_type
    column :start_at
    column :end_at
    column :type
    column :level_type
    column :created_at
    actions
  end

  filter :coin_type, as: :select
  filter :start_at, as: :select
  filter :end_at, as: :select

end
