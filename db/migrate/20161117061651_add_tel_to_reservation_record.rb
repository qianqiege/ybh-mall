class AddTelToReservationRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :reservation_records, :tel, :string
  end
end
