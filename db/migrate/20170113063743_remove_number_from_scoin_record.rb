class RemoveNumberFromScoinRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :scoin_records, :number, :integer
  end
end
