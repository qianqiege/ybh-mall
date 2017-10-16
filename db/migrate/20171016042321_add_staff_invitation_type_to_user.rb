class AddStaffInvitationTypeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :staff_invitation_type, :string
  end
end
