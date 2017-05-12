class CreateGameUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :game_users do |t|
      t.integer :user_id
      t.string :user_name
      t.float :number
      t.integer :ranking

      t.timestamps
    end
  end
end
