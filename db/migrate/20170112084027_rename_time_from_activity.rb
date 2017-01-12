class RenameTimeFromActivity < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :time, :datetime
    add_column :activities, :start_time, :datetime
    add_column :activities, :stop_time, :datetime
  end
end
