class RenameMemberRank < ActiveRecord::Migration[5.0]
  def change
    rename_table :member_ranks,:member_clubs
  end
end
