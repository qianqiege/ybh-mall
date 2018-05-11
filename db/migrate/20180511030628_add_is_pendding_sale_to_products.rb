class AddIsPenddingSaleToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_pendding_sale, :boolean
  end
end
