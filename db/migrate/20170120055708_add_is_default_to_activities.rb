class AddIsDefaultToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :is_default, :boolean, default: false
  end
end
