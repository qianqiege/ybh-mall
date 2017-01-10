class CreateLongPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :long_programs do |t|
      t.string :doctor
      t.string :hospital
      t.string :recipe_number
      t.decimal :total
      t.string :detail
      t.integer :blood_letting
      t.integer :treatment

      t.timestamps
    end
  end
end
