class AddCommunityIdToUsers < ActiveRecord::Migration[5.0]
  def change
      add_column :users, :community_id :integer
      add_column :users, :maker_id, :integer
  end
end
