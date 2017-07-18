class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer :product_id
      t.integer :day
      t.integer :number
      t.boolean :is_default

      t.timestamps
    end
  end
end
