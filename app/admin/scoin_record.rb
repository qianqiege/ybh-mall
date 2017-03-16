ActiveAdmin.register ScoinRecord do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :state, :scoin_account_id, :scoin_type_id, :start_at, :end_at

  form(:html => { :multipart => true }) do |f|
    f.inputs "S货币记录" do
      f.input :scoin_account
      f.input :scoin_type
      f.input :start_at, as: :datepicker
      f.input :end_at, as: :datepicker
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :scoin_account
    column :scoin_type
    column :start_at
    column :end_at
    column :created_at
    actions
  end

  filter :scoin_account, as: :select
  filter :scoin_type, as: :select
  filter :start_at, as: :select
  filter :end_at, as: :select

end
