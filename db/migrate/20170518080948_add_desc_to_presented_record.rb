class AddDescToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :desc, :string
  end
end
