class AddStateToHightTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :hight_tickets, :state, :string
  end
end
