class AddPromiseMoneyToPlans < ActiveRecord::Migration[5.0]
  def change
      add_column :plans, :promise_money, :decimal, precision: 10, scale: 2
  end
end
