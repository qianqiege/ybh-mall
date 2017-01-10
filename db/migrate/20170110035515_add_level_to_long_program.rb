class AddLevelToLongProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :long_programs, :level, :string
  end
end
