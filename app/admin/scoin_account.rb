ActiveAdmin.register ScoinAccount do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :account, :password,:state,:user_id,:number, :order_id

  form do |f|
    f.inputs "S币账户" do
      f.input :user
      # f.input :order
      # f.input :order_id, as: :nested_select,
      #                    level_1: { attribute: :user_id, fields: [:identity_card], display_name: :identity_card, minimum_input_length: 0 },
      #                    level_2: { attribute: :order_id, fields: [:number], display_name: :number, minimum_input_length: 0 }
      f.input :account
      f.input :password
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :user
    column :account
    column :password
    column :number
    actions
  end
end
