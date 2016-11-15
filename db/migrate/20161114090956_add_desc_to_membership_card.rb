class AddDescToMembershipCard < ActiveRecord::Migration[5.0]
  def change
    add_column :membership_cards, :desc, :text
  end
end
