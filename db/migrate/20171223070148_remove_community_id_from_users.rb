class RemoveCommunityIdFromUsers < ActiveRecord::Migration[5.0]
  def change
      remove_column :users, :community_id, :integer
      remove_column :users, :maker_id, :integer
  end
end
