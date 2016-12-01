class RemoveUserIdToExamineRecord < ActiveRecord::Migration[5.0]
  def change
    remove_column :examine_records, :user_id, :integer
  end
end
