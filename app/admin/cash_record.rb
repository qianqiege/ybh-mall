ActiveAdmin.register CashRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")

  actions :index, :show ,:new ,:create
  permit_params :user_id,:number,:status,:is_effective,:wight,:reason,:type

  index do
    selectable_column
    id_column

    column :user
    column :reason
    column :number
    column :is_effective
    column :status
    column :account
    column :desc
    column :created_at
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "积分" do
      f.input :user
      f.input :number
      f.input :status, as: :select, collection: ["人工创建"]
      f.input :is_effective
      f.input :reason, as: :select, collection: [ '消费','充值' ]
      f.input :type, as: :select, collection: { '可以提现' => 'CashYes', '不可提现' => 'CashNo' }
      f.input :desc
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :user
      row :number
      row :status
      row :is_effective
      row :created_at
      row :type
    end
  end

end
