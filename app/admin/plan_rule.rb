ActiveAdmin.register PlanRule do
permit_params :name, :invite_count, :commitment_consumption_amount, :start_money, :amount_of_promised_income, :ratio
end
