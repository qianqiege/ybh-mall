class CreateServes < ActiveRecord::Migration[5.0]
  def change
    create_table :serves do |t|
      t.string :server_name
      t.string :server_level
      t.string :server_money

      t.timestamps
    end
  end
end
