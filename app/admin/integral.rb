ActiveAdmin.register Integral do
menu parent: I18n.t("active_admin.menu.wallet_manage")

permit_params :exchange, :user_id, :locking, :available,:cash,:not_exchange, :celebrate_ratsimp, :not_cash, :allocation_money

  index do
    selectable_column
    id_column

    column :user_id
    column :locking
    column :available
    column :exchange
    column :not_exchange
    column :cash
    column :not_cash
    column :celebrate_ratsimp
    column :updated_at
    column :allocation_money
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "钱包" do
      f.input :user
      f.input :locking
      f.input :available
      f.input :cash
      f.input :not_cash
      f.input :not_exchange
      f.input :celebrate_ratsimp
    end
    f.actions
  end

end
