class AddChinaCityToParallelShops < ActiveRecord::Migration[5.0]
  def change
  	add_column :parallel_shops, :province, :string
  	add_column :parallel_shops, :city, :string
  	add_column :parallel_shops, :street, :string
  	add_column :parallel_shops, :detail, :string
  end
end
