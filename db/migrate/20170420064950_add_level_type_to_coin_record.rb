class AddLevelTypeToCoinRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :coin_records, :level_type, :string
  end
end
