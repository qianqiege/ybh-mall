class AddMembershipCardIdToMemberRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :member_records, :membership_card_id, :integer
  end
end
