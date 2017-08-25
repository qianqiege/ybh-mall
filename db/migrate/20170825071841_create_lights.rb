class CreateLights < ActiveRecord::Migration[5.0]
  def change
    create_table :lights do |t|
      t.string :city
      t.text :desc
      t.string :image
      t.datetime :strat
      t.datetime :over

      t.timestamps
    end
  end
end
