class AddStateToDoctorOrUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :doctor_or_users, :state, :string
  end
end
