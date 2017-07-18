class CreateEvaluationRules < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_rules do |t|
      t.integer :evaluation_id
      t.integer :weight
      t.float :user_proportion
      t.decimal :doctor,:precision => 10,:scale=>2

      t.timestamps
    end
  end
end
