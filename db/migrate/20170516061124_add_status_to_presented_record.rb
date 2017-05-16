class AddStatusToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :status, :string
  end
end
