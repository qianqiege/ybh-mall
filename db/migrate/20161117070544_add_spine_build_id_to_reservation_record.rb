class AddSpineBuildIdToReservationRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :reservation_records, :spine_build_id, :integer
  end
end
