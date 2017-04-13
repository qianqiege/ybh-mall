class AddTypeToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :type, :string
  end
end
