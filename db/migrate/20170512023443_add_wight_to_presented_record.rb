class AddWightToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :wight, :integer
  end
end
