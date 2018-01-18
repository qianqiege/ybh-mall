class AddCelebrateRatsimpToIntegral < ActiveRecord::Migration[5.0]
  def change
      add_column :integrals, :celebrate_ratsimp, :float, default: 0.0
  end
end
