class CreateBloodGlucoses < ActiveRecord::Migration[5.0]
  def change
    create_table :blood_glucoses do |t|
      t.float :value
      t.datetime :time

      t.timestamps
    end
  end
end
