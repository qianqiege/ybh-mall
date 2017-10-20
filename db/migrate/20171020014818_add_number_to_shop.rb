class AddNumberToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :number, :integer
  end
end
