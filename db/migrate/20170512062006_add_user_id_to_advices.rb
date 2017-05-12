class AddUserIdToAdvices < ActiveRecord::Migration[5.0]
  def change
    add_column :advices, :user_id, :integer
  end
end
