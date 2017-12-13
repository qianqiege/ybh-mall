class AddIsTestToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :is_test, :boolean,  default: false
  end
end
