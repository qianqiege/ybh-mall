class AddYterProfileToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :yter_profile, :integer, default: 0
  end
end
