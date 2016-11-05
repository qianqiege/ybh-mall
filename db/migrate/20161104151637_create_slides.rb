class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|
      t.string :desc
      t.string :url
      t.string :image
      t.boolean :is_show
      t.integer :weight

      t.timestamps
    end
  end
end
