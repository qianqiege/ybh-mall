ActiveAdmin.register ScoinAccountOrderRelation do
  menu parent: I18n.t("active_admin.menu.coin_manage")
  permit_params :order_id, :scoin_account_id

  collection_action :user_orders, method: :get do
    user_id = ScoinAccount.find_by(params[:q][:scoin_account_id_eq]).try(:user_id)
    query = params[:q]
    query.delete(:scoin_account_id_eq)
    query[:user_id_eq] = user_id
    render json: Order.search(query).result
  end

  form do |f|
    f.inputs "S币账户" do
      # f.input :order
      # f.input :scoin_account
      f.input :order_id, as: :nested_select,
                         level_1: { attribute: :scoin_account_id, fields: [:account], display_name: :account, minimum_input_length: 0 },
                         level_2: { attribute: :order_id, fields: [:number], display_name: :number, minimum_input_length: 0, url: "/admin/scoin_account_order_relations/user_orders" }

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
