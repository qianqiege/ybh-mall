class CreateSharingPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :sharing_plans do |t|
      t.string :name
      t.integer :invite_count
      t.string :plan_type

      t.timestamps
    end
  end
end
