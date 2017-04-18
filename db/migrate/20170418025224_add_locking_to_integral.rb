class AddLockingToIntegral < ActiveRecord::Migration[5.0]
  def change
    add_column :integrals, :locking, :decimal
    add_column :integrals, :available, :decimal
  end
end
