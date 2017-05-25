class AddStaffToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :staff, :decimal, precision: 10, scale: 2
  end
end
