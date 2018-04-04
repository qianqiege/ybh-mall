class AddIsEntrustToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_entrust, :boolean
  end
end
