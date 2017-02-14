class AddInvitationCardToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invitation_card, :string
    add_column :users, :invitation_user, :string
  end
end
