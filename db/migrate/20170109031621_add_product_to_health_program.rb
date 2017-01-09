class AddProductToHealthProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :health_programs, :product, :string
  end
end
