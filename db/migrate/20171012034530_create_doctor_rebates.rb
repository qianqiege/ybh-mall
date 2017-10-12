class CreateDoctorRebates < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_rebates do |t|
      t.integer :user_id
      t.string :state
      t.float :money
      t.string :account

      t.timestamps
    end
  end
end
