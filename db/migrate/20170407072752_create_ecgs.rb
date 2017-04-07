class CreateEcgs < ActiveRecord::Migration[5.0]
  def change
    create_table :ecgs do |t|
      t.string :url
      t.integer :user_id
      t.string :phone
      t.string :state

      t.timestamps
    end
  end
end
