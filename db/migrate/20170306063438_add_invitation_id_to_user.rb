class AddInvitationIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invitation_id, :integer
  end
end
