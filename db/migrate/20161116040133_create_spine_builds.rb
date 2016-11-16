class CreateSpineBuilds < ActiveRecord::Migration[5.0]
  def change
    create_table :spine_builds do |t|
      t.string :name

      t.integer :workstation_id
      t.integer :rank_id
      t.integer :serve_id
      t.timestamps
    end
  end
end
