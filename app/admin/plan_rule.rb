ActiveAdmin.register PlanRule do
    menu parent: I18n.t("active_admin.menu.activity_manage")
    permit_params :name, :sharing_plan_id, :commitment_consumption_amount, :start_money, :earning_ratio, :amount_of_promised_income, :ratio
    form(:html => { :multipart => true }) do |f|
      f.inputs "计划规则" do
        f.input :name
        f.input :commitment_consumption_amount
        f.input :start_money
        f.input :amount_of_promised_income
        f.input :ratio
        f.input :earning_ratio
        f.input :sharing_plan
      end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :name
        column :sharing_plan
        column :commitment_consumption_amount
        column :start_money
        column :amount_of_promised_income
        column :ratio
        column :earning_ratio
        actions
    end
end
