class AddApplyCodeIdToPresentedRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :presented_records, :code_id, :integer
  end
end
