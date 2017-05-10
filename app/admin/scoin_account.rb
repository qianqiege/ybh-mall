ActiveAdmin.register ScoinAccount do
  menu parent: I18n.t("active_admin.menu.wallet_manage")
  permit_params :account, :password,:state,:user_id,:number, :order_id,:email

  form do |f|
    f.inputs "S货币账户" do
      f.input :user
      f.input :account
      f.input :email
      f.input :password
      f.input :state
      f.input :number
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :user
    column :account
    column :password
    column :email
    column :number
    column :state
    actions
  end

  filter :user, as: :select
  filter :account, as: :select
  filter :email, as: :select
  filter :number, as: :select
  filter :state, as: :select
end
