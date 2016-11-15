class RemoveServerLevelFromServe < ActiveRecord::Migration[5.0]
  def change
    remove_column :serves, :serve_level, :string
    remove_column :serves, :serve_money, :float
  end
end
