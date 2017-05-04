class RemoveBronzeFromIntegral < ActiveRecord::Migration[5.0]
  def change
    remove_column :integrals, :bronze, :decimal
    remove_column :integrals, :silver, :decimal
    remove_column :integrals, :gold, :decimal
    add_column :integrals, :exchange, :decimal
  end
end
