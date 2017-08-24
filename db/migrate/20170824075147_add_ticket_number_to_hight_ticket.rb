class AddTicketNumberToHightTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :hight_tickets, :ticket_number, :string
  end
end
