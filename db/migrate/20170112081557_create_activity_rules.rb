class CreateActivityRules < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_rules do |t|
      t.string :rule

      t.timestamps
    end
  end
end
