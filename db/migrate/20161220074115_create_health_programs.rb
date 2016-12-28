class CreateHealthPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :health_programs do |t|
      t.string :name
      t.string :identity_card
      t.integer :number
      t.string :only_number
      t.datetime :time
      t.string :coding

      t.timestamps
    end
  end
end
