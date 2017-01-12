class AddActivityIdToActivityRule < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_rules, :activity_id, :integer
  end
end
