ActiveAdmin.register Integral do
menu parent: I18n.t("active_admin.menu.wallet_manage")

permit_params :exchange, :user_id, :locking, :available,:appreciation,:cash,:not_exchange,:not_appreciation,:count,:not_cash

  index do
    selectable_column
    id_column

    column :user_id
    column :locking
    column :available
    column :exchange
    column :appreciation
    column :cash
    column :not_exchange
    column :not_cash
    column :not_appreciation
    column :count
    column :updated_at
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "钱包" do
      f.input :user
      f.input :locking
      f.input :available
      f.input :exchange
      f.input :appreciation
      f.input :cash
      f.input :not_exchange
      f.input :not_cash
      f.input :not_appreciation
      f.input :count
    end
    f.actions
  end

end
