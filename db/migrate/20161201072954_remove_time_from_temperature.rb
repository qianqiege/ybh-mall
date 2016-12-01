class RemoveTimeFromTemperature < ActiveRecord::Migration[5.0]
  def change
    remove_column :temperatures, :time, :datetime
  end
end
