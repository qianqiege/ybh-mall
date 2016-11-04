class CreateSetMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :set_meals do |t|
      t.integer :vip_type_id
      t.string :type
      t.string :cost
      t.string :name

      t.timestamps
    end
  end
end
