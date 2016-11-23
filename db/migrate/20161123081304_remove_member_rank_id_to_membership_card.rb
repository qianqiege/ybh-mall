class RemoveMemberRankIdToMembershipCard < ActiveRecord::Migration[5.0]
  def change
    remove_column :membership_cards, :member_rank_id, :integer
  end
end
