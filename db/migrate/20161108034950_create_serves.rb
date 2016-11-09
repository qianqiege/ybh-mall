class CreateServes < ActiveRecord::Migration[5.0]
  def change
    create_table :serves do |t|
      t.string :serve_name
      t.string :serve_level
      t.float :serve_money

      t.timestamps
    end
  end
end
