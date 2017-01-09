class CreateProductPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :product_programs do |t|
      t.string :name
      t.integer :number
      t.string :only_number
      t.string :identity_card
      t.integer :health_program_id

      t.timestamps
    end
  end
end
