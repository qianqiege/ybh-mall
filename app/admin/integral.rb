ActiveAdmin.register Integral do
menu parent: I18n.t("active_admin.menu.wallet_manage")

permit_params :exchange, :user_id, :locking, :available,:cash,:not_exchange

  index do
    selectable_column
    id_column

    column :user_id
    column :locking
    column :exchange
    column :not_exchange
    column :cash
    column :not_cash
    column :updated_at
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "钱包" do
      f.input :user
      f.input :locking
      f.input :cash
      f.input :not_exchange
    end
    f.actions
  end

  filter :user

end
