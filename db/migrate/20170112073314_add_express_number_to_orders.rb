class AddExpressNumberToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :express_number, :string
  end
end
