class AddIdNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :id_number, :string
  end
end
