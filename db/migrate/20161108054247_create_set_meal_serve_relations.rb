class CreateSetMealServeRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :set_meal_serve_relations do |t|
      t.integer :server_id
      t.integer :setmeal_id

      t.timestamps
    end
  end
end
