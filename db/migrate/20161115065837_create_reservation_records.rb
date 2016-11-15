class CreateReservationRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :reservation_records do |t|
      t.string :name
      t.datetime :time

      t.integer :service_staff_id
      t.integer :serve_id
      t.timestamps
    end
  end
end
