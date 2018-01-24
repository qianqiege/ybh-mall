ActiveAdmin.register PlanRule do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :name, :invite_count, :commitment_consumption_amount, :start_money, :earning_ratio, :amount_of_promised_income, :ratio, :link
    form(:html => { :multipart => true }) do |f|
      f.inputs "计划规则" do
        f.input :name
        f.input :invite_count
        f.input :commitment_consumption_amount
        f.input :start_money
        f.input :amount_of_promised_income
        f.input :ratio
        f.input :earning_ratio
        f.input :plan_type, as: :select, collection: ['199', '177', '155', '133', '122']
        f.input :link
      end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :name
        column :invite_count
        column :commitment_consumption_amount
        column :start_money
        column :amount_of_promised_income
        column :ratio
        column :earning_ratio
        column :plan_type
        column :link
        actions
    end
end
