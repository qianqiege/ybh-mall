class AddOrderIdToCelebrateRatsimp < ActiveRecord::Migration[5.0]
  def change
      add_column :celebrate_ratsimps, :order_id, :integer
  end
end
