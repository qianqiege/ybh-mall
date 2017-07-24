class AddEvaluationNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :evaluation_number, :integer
  end
end
