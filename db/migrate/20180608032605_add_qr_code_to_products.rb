class AddQrCodeToProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :qr_code, :string
  end
end
