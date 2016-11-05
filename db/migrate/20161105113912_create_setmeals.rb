class CreateSetmeals < ActiveRecord::Migration[5.0]
  def change
    create_table :setmeals do |t|
      t.string :name
      t.string :image
      t.text :content
      t.string :type
      t.float :const

      t.timestamps
    end
  end
end
