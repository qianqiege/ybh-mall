class AddLampNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lamp_number, :integer
  end
end
