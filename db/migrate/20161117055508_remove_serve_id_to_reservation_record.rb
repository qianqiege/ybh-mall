class RemoveServeIdToReservationRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservation_records, :serve_id, :integer
  end
end
