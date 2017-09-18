class AddRoleToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules,:health_manager,  :decimal,precision: 10, scale: 2
    add_column :activity_rules,:family_health_manager, :decimal,precision: 10, scale: 2
    add_column :activity_rules,:family_doctor, :decimal,precision: 10, scale: 2
  end
end
