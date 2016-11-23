class AddMemberClubIdToMembershipCard < ActiveRecord::Migration[5.0]
  def change
    add_column :membership_cards, :member_club_id, :integer
  end
end
