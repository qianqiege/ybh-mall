class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :simple_desc
      t.integer :sort
      t.string :image
      t.text :desc
      t.timestamps
    end
  end
end
