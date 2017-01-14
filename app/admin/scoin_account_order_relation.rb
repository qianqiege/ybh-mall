ActiveAdmin.register ScoinAccountOrderRelation do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :order_id, :scoin_account_id

  form do |f|
    f.inputs "S币账户" do
      f.input :order
      f.input :scoin_account
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :order
    column :scoin_account
    actions
  end

end
