class AddFeaturesToProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :programs, :features, :string
    add_column :programs, :effect, :string
    add_column :programs, :crowd, :string
  end
end
