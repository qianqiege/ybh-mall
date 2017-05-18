class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.string :desc
      t.string :image
      t.boolean :is_show

      t.timestamps
    end
  end
end
