class CreateDoctorOrUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_or_users do |t|
      t.integer :user_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
