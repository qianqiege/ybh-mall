class RemoveTimeFromWeight < ActiveRecord::Migration[5.0]
  def change
    remove_column :weights, :time, :datetime
  end
end
