class RemoveLockingYFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :locking_y, :decimal
    remove_column :users, :available_y, :decimal
  end
end
