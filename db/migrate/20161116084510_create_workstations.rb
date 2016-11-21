class CreateWorkstations < ActiveRecord::Migration[5.0]
  def change
    create_table :workstations do |t|
      t.string :name
      t.string :city
      t.integer :service_staff_id

      t.timestamps
    end
  end
end
