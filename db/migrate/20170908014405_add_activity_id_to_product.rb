class AddActivityIdToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :activity_id, :integer
  end
end
