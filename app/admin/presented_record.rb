ActiveAdmin.register PresentedRecord do
  menu parent: I18n.t("active_admin.menu.coin_record_manage")
  actions :index, :show ,:new ,:create
  permit_params :user_id,:number,:status,:is_effective,:wight,:desc

  index do
     selectable_column
     id_column

     column :user_id
     column :number
     column :reason
     column :created_at
     # column :organization
     column :is_effective
     column :record_id
     column :type
     column :status
     column :balance
     column :desc
     column "权重",:wight
     actions
   end

   form(:html => { :multipart => true }) do |f|
     f.inputs "积分" do
       f.input :user
       f.input :number
       f.input :status, as: :select, collection: ["人工创建"]
       f.input :is_effective
       f.input :wight, as: :select, collection: { '可兑换积分' => '1', '不可兑换积分' => '2','锁定积分' => '3'}
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
       row :wight
       row :desc
       row :created_at
     end
   end


   filter :user, as: :select
   filter :status, as: :select
   filter :reason, as: :select
   filter :number, as: :select
   filter :type, as: :select
   filter :is_effective, as: :select

end
