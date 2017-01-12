class AddTimeToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :time, :datetime
  end
end
