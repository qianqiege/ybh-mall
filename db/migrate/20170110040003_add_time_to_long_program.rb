class AddTimeToLongProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :long_programs, :time, :datetime
  end
end
