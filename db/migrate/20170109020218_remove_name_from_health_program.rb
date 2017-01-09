class RemoveNameFromHealthProgram < ActiveRecord::Migration[5.0]
  def change
    remove_column :health_programs, :name, :string
    remove_column :health_programs, :only_number, :string
    remove_column :health_programs, :number, :integer
  end
end
