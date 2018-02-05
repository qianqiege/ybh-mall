class RemoveAmountOfPromisedIncomeFromPlanRules < ActiveRecord::Migration[5.0]
  def change
    remove_column :plan_rules, :amount_of_promised_income, :float
    remove_column :plan_rules, :ratio, :float
  end
end
