ActiveAdmin.register Integral do
menu parent: I18n.t("active_admin.menu.wallet_manage")

permit_params :exchange, :user_id, :locking, :available

  index do
    selectable_column
    id_column

    column :user_id
    column :locking
    column :available
    column :exchange
    column :cash
    column :updated_at
    actions defaults: true
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "积分详表" do
      f.input :user
      f.input :locking
      f.input :available
      f.input :exchange
    end
    f.actions
  end

end
