class AddProgramsNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :programs_number, :string
  end
end
