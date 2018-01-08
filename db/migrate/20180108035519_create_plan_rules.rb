class CreatePlanRules < ActiveRecord::Migration[5.0]
  def change
    create_table :plan_rules do |t|
      t.string :name
      t.integer :invite_count
      t.float :commitment_consumption_amount
      t.float :start_money
      t.float :amount_of_promised_income
      t.float :ratio

      t.timestamps
    end
  end
end
