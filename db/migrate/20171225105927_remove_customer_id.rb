class RemoveCustomerId < ActiveRecord::Migration[5.0]
  def change
      remove_column :shop_orders, :customer
      add_column :shop_orders, :wechat_user_id, :integer
  end
end
