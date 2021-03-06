ActiveAdmin.register Plan do
  menu parent: I18n.t("active_admin.menu.activity_manage")
  permit_params :user_id, :active, :plan_rule_id, :money, :invite_plan_id, :is_end

  index do
    selectable_column
    id_column
    column :user
    column :code
    column :is_end
    column :invite_plan_id
    column :active
    column :money
    column :plan_rule_id
    column '支付方式' do |payment|
      payment.pay_ment
    end
    column "线下支付确认" do |plan|
      link_to "确认线下支付", payment_admin_plan_path(plan), method: :put, data: {confirm: 'Are you sure?'} if plan.payment == "1" && plan.status == "failing"
    end
    column :status
    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs "计划" do
      f.input :user
      f.input :is_end
      f.input :invite_plan_id
      f.input :active
      f.input :money
      f.input :plan_rule
    end
    f.actions
  end

  member_action :payment, method: :put do
    resource.pay
    resource.active = true
    resource.save
    redirect_to admin_plans_path
  end
end
