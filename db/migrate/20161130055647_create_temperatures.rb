class CreateTemperatures < ActiveRecord::Migration[5.0]
  def change
    create_table :temperatures do |t|
      t.float :value
      t.datetime :time

      t.timestamps
    end
  end
end
