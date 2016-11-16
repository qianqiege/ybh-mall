class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.string :level

      t.timestamps
    end
  end
end
