class AddRemarkToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :remark, :string
  end
end
