class AddCityToHightTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :hight_tickets, :city, :string
  end
end
