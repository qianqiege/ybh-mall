class ChangeOriginalProductPriceFromProduct < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :original_product_price, :decimal,:precision => 10,:scale=>2
    change_column :products, :now_product_price, :decimal,:precision => 10,:scale=>2
  end
end
