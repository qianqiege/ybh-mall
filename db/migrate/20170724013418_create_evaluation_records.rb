class CreateEvaluationRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluation_records do |t|
      t.integer :order_id
      t.string :order_number
      t.integer :evalation_number
      t.boolean :is_state

      t.timestamps
    end
  end
end
