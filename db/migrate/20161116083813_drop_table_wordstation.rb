class DropTableWordstation < ActiveRecord::Migration[5.0]
  def change
    drop_table :wordstations
  end
end
