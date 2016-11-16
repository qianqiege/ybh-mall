class CreateWordstations < ActiveRecord::Migration[5.0]
  def change
    create_table :wordstations do |t|
      t.string :name
      t.string :city

      t.integet :service_staff_id
      t.timestamps
    end
  end
end
