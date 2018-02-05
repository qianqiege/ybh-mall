class AddInstructionToSharingPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :sharing_plans, :instruction, :text
  end
end
