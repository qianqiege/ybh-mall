class AddParallelShopIdToShopOrder < ActiveRecord::Migration[5.0]
  def change
      add_column :shop_orders, :parallel_shop_id, :integer
      add_column :shop_orders, :call_number, :string
  end
end
