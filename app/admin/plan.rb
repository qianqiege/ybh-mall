ActiveAdmin.register Plan do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :user_id, :is_capital, :capital_id, :active, :is_maker, :plan_type, :money, :invite_plan_id
    form(:html => { :multipart => true }) do |f|
      f.inputs "计划" do
        f.input :user
        f.input :is_capital
        f.input :capital_id
        f.input :invite_plan_id
        f.input :active
        f.input :is_maker
        f.input :money
        f.input :plan_type, as: :select, collection: ['199', '177', '155', '133', '122']
      end
      f.actions
    end

    member_action :payment, method: :put do
        resource.active = true
        resource.save
        redirect_to admin_plans_path
    end

    index do
        selectable_column
        id_column
        column :user
        column :code
        column :is_capital
        column :capital_id
        column :invite_plan_id
        column :active
        column :is_maker
        column :money
        column :plan_type
        column '支付方式' do |plan|
            if plan.payment == 'PAYMENT_TYPE_NULL'
                '线下支付'
            else
                '微信支付'
            end
        end
        column "操作" do |plan|
            link_to "确认线下支付", payment_admin_plan_path(plan), method: :put, data: { confirm: 'Are you sure?' } if plan.payment == "PAYMENT_TYPE_NULL" && !plan.active
        end
        actions
    end
end
