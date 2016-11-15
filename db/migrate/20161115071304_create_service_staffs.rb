class CreateServiceStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :service_staffs do |t|
      t.string :name
      t.string :grade
      t.string :city
      t.integer :serve_number

      t.integer :serve_id
      t.timestamps
    end
  end
end
