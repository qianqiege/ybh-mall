class AddShopInfosToShops < ActiveRecord::Migration[5.0]
  def change
  	add_column :shops, :morning_start, :string
  	add_column :shops, :morning_end, :string
  	add_column :shops, :afternoon_start, :string
  	add_column :shops, :afternoon_end, :string
  	add_column :shops, :user_id_card, :string
  	add_column :shops, :user_image, :string
  	add_column :shops, :license_image, :string
    add_column :shops, :license_number, :string
  	add_column :shops, :state, :string
  end
end
