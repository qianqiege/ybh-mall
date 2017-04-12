class AddStateToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :is_effective, :boolean
  end
end
