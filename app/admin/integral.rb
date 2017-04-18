ActiveAdmin.register Integral do
menu parent: I18n.t("active_admin.menu.coin_manage")

permit_params :bronze, :silver, :gold, :user_id

  index do
    selectable_column
    id_column

    column :user_id
    column :bronze
    column :silver
    column :gold
    column :updated_at
    actions defaults: true
  end

end
