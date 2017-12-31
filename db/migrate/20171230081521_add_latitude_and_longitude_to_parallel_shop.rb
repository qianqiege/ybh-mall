class AddLatitudeAndLongitudeToParallelShop < ActiveRecord::Migration[5.0]
  def change
    add_column :parallel_shops, :latitude, :float
    add_column :parallel_shops, :longitude, :float
  end
end
