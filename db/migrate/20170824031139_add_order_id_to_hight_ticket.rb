class AddOrderIdToHightTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :hight_tickets, :order_id, :integer
  end
end
