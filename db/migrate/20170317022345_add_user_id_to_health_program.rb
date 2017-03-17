class AddUserIdToHealthProgram < ActiveRecord::Migration[5.0]
  def change
    add_column :health_programs, :user_id, :integer
  end
end
