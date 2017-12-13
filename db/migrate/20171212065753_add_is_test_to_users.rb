class AddIsTestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_test, :boolean,  default: false
  end
end
