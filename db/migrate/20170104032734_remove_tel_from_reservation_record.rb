class RemoveTelFromReservationRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservation_records, :tel, :string
    add_column :reservation_records, :identity_card, :string
  end
end
