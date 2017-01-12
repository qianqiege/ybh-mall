class ChangeProductFromHealthProgram < ActiveRecord::Migration[5.0]
  def change
    remove_column :health_programs, :product, :string
    add_column :health_programs, :product, :text
  end
end
