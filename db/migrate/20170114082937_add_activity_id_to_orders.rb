class AddActivityIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :activity_id, :integer
  end
end
