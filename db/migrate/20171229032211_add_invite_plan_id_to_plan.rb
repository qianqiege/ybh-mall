class AddInvitePlanIdToPlan < ActiveRecord::Migration[5.0]
  def change
      add_column :plans, :invite_plan_id, :integer
  end
end
