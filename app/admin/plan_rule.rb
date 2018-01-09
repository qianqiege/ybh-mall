ActiveAdmin.register PlanRule do
    menu parent: I18n.t("active_admin.menu.parallel_shop_manage")
    permit_params :name, :simple_name, :invite_count, :commitment_consumption_amount, :start_money, :amount_of_promised_income, :ratio, :plan_type
    form(:html => { :multipart => true }) do |f|
      f.inputs "计划规则" do
        f.input :name
        f.input :simple_name
        f.input :invite_count
        f.input :commitment_consumption_amount
        f.input :start_money
        f.input :amount_of_promised_income
        f.input :ratio
        f.input :plan_type, as: :select, collection: ['199', '177', '155', '133', '122']
      end
      f.actions
    end

    index do
        selectable_column
        id_column
        column :name
        column :simple_name
        column :invite_count
        column :commitment_consumption_amount
        column :start_money
        column :amount_of_promised_income
        column :ratio
        column :plan_type
        actions
    end
end
