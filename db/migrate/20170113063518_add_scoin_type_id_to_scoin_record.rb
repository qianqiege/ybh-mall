class AddScoinTypeIdToScoinRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :scoin_records, :scoin_type_id, :integer
  end
end
