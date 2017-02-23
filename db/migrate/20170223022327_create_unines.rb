class CreateUnines < ActiveRecord::Migration[5.0]
  def change
    create_table :unines do |t|
      t.float :value
      t.string :phone
      t.string :state
      t.integer :user_id

      t.timestamps
    end
  end
end
